class StaticController < ApplicationController
  def getting_started
  end

  def faq
  end

  def java_exercises
    @problems = Xapi::Config.find('java').problems
  end

  def ruby_exercises
    @problems = Xapi::Config.find('javascript').problems
  end

  def javascript_exercises
    @problems = Xapi::Config.find('ruby').problems
  end
end
