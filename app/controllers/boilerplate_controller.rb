class BoilerplateController < ApplicationController
  def index
    @quizzes = Quiz.popular
  end
end
