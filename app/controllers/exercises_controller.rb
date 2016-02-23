class ExercisesController < ApplicationController
  def readme
    config = Xapi::Config.find(params[:language]).find(params[:track])
    @problem = Exercism::Problem.new(config.language.downcase, config.slug)
    @text = Exercism::ConvertsMarkdownToHTML.convert(config.readme)
  end
end
