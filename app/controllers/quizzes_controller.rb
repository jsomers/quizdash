class QuizzesController < ApplicationController
  def show
  end
  
  def new
    @quiz = Quiz.new
    @quiz.questions.build
  end
  
  def create
    @quiz = Quiz.new(params[:quiz])
    if @quiz.save
      redirect_to @quiz
    else
      render :action => :new
    end
  end
  
  def edit
  end
  
  def update
  end

end
