module Exercism
  class CodeAnalyzer
    attr_reader :language, :code, :commit_id, :git_rep_info, :user

    def initialize(options = {})
      @language = options[:language]
      @code = options[:code]
      @commit_id = options[:commit_id]
      @git_rep_info = options[:git_rep_info]
      @user = options[:user]
    end

    def jenkins_url
      ENV.fetch('JENKINS_URL') { "http://labs.imaginea.com/jenkins" }
    end

    def sonarqube_url
      ENV.fetch('SONARQUBE_URL') { "http://labs.pramati.com:9005/sonar" }
    end

    def xml_language_name
      case @language
      when 'java'
        'java'
      when 'javascript'
        'js'
      else
        'java'
      end
    end

    def run
      projectName = user.username + user.id.to_s + git_rep_info.split('/').last
      xml = "
   <project>
      <actions/>
      <description/>
      <keepDependencies>false</keepDependencies>
      <properties>
        <com.coravy.hudson.plugins.github.GithubProjectProperty plugin='github@1.11.3'>
          <projectUrl>https://github.com/#{git_rep_info}</projectUrl>
        </com.coravy.hudson.plugins.github.GithubProjectProperty>
      </properties>
      <scm class='hudson.plugins.git.GitSCM' plugin='git@2.3.5'>
        <configVersion>2</configVersion>
        <userRemoteConfigs><hudson.plugins.git.UserRemoteConfig>
          <url>https://github.com/#{git_rep_info}.git</url></hudson.plugins.git.UserRemoteConfig>
        </userRemoteConfigs>
        <branches>
          <hudson.plugins.git.BranchSpec><name>#{code}</name></hudson.plugins.git.BranchSpec>
        </branches>
        <doGenerateSubmoduleConfigurations>false</doGenerateSubmoduleConfigurations>
        <submoduleCfg class='list'/><extensions/>
      </scm>
      <canRoam>true</canRoam>
      <disabled>false</disabled>
      <blockBuildWhenDownstreamBuilding>false</blockBuildWhenDownstreamBuilding>
      <blockBuildWhenUpstreamBuilding>false</blockBuildWhenUpstreamBuilding>
      <triggers/>
      <concurrentBuild>false</concurrentBuild>
      <builders>
        <hudson.plugins.sonar.SonarRunnerBuilder plugin='sonar@2.2.1'><project/>
        <properties># required metadata
          sonar.projectKey=#{projectName}
          sonar.projectName=#{projectName}
          sonar.projectVersion=2.0
          # path to source directories (required)
          sonar.language=#{xml_language_name}
          sonar.sources=src
          sonar.analysis.mode=preview
          sonar.issuesReport.html.enable=true
        </properties>
        <javaOpts/>
        <jdk>(Inherit From Job)</jdk>
        <task/>
        </hudson.plugins.sonar.SonarRunnerBuilder>
      </builders>
      <publishers/><buildWrappers/>
    </project>"
      json_params = { :content_type => "application/json" }
      jobs = RestClient.get "#{jenkins_url}/api/json?tree=jobs[name]", json_params
      jobs = JSON.parse(jobs)
      jobs_exist = jobs["jobs"].select{|job| job["name"] == projectName}
      new_job_url = "#{jenkins_url}/createItem?name=#{projectName}"
      if jobs_exist.empty?
        create_job_response = RestClient.post new_job_url, xml, { :content_type => "application/xml" }
      else
        update_job_url = "#{jenkins_url}/job/#{projectName}/config.xml"
        update_job = RestClient.post update_job_url, xml, { :content_type => "application/xml" }
      end
      sleep 20
      build = RestClient.post "#{jenkins_url}/job/"+projectName+"/build", json_params

      if build.code == 201
        url = "#{jenkins_url}"+"/job/"+"#{projectName}"+"/lastBuild/api/json"
        sleep 40
        build_status_response = RestClient.get url, json_params
        response = JSON.parse(build_status_response)
        if response["result"] == "SUCCESS"
          result = RestClient.get("#{jenkins_url}"+"/job/"+"#{projectName}"+"/ws/.sonar/sonar-report.json", json_params)
          result = JSON.parse(result)
          result['issues'] = result['issues'].sort_by!{|i| i['component'] && (i['line'].nil? ? 0 : i['line'])}
          return result
        else
          return {error: "Failed"}.to_json
        end
      else
        return {error: "Unable to create the job"}.to_json
      end
    end

    def self.class_exists?(class_name)
      klass = Module.const_get(class_name)
      return klass.is_a?(Class)
    rescue NameError
      return false
    end

    def self.build(options = {})
      options[:language] ||= ""
      if options[:language].strip.empty?
        CodeAnalyzer.new(options)
      else
        klass = options[:language].strip.capitalize
        if class_exists?(klass)
          const_get(klass).new(options)
        else
          CodeAnalyzer.new(options)
        end
      end
    end
  end

  class Ruby < CodeAnalyzer
    def run
      unless ENV.fetch('RACK_ENV') == "test"
        file_name = "#{settings.root}/rubocop_tmp/test_#{user.id}.rb"
        rubocop_code_file = File.new(file_name, "w+")
        rubocop_code_file.write code
        rubocop_code_file.rewind
        analysis = `rubocop "#{rubocop_code_file.path}"`
        File.delete rubocop_code_file.path
        analysis
      end
    end
  end
end
