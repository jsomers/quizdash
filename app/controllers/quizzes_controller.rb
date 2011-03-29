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
    processed_params = (params[:csv] ? Quiz.attach_csv_questions(params[:quiz], params[:csv][:file]) : params[:quiz])
    @quiz = Quiz.new(processed_params)
    if @quiz.save
      redirect_to :action => :index
    else
      render :action => :new
    end
  end
  
  def edit
    @quiz = Quiz.find(params[:id])
  end
  
  def update
    @quiz = Quiz.find(params[:id])
    processed_params = (params[:csv] ? Quiz.attach_csv_questions(params[:quiz], params[:csv][:file]) : params[:quiz])
    @quiz.attributes = processed_params
    if @quiz.save
      redirect_to :action => :index
    else
      render :action => :edit
    end
  end
  
  def destroy
    @quiz = Quiz.find(params[:id])
    @quiz.destroy
    render :text => "OK"
  end
end
