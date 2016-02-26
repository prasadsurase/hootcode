class ExercisesController < ApplicationController
  def readme
    begin
      config = Xapi::Config.find(params[:language]).find(params[:track])
      @problem = Exercism::Problem.new(config.language.downcase, config.slug)
      @text = Exercism::ConvertsMarkdownToHTML.convert(config.readme)
    rescue
      redirect_to root_path and return
    end
  end
end
