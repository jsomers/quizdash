class BoilerplateController < ApplicationController
  def index
    @quizzes = Quiz.all
  end
end
