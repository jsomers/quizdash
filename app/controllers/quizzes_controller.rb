class QuizzesController < ApplicationController
  
  def index
    @quizzes = Quiz.all
  end
  
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
    @quiz = Quiz.find(params[:id])
  end
  
  def update
    @quiz = Quiz.find(params[:id])
    @quiz.attributes = params[:quiz]
    if @quiz.save
      redirect_to @quiz
    else
      render :action => :edit
    end
  end

end
