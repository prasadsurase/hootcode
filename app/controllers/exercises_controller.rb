class ExercisesController < ApplicationController

  def readme
    config = Xapi::Config.find(params[:language]).find(params[:track])
    problem = Problem.new(config.language, config.slug)
    binding.pry
  end
end
