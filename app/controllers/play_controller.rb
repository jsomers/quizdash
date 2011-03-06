class PlayController < ApplicationController
  def quiz
    @quiz = Quiz.find(params[:id].split("-").first)
    @hash = Digest::MD5.hexdigest(params[:id]).first(10)
  end
  
  def msg
    Juggernaut.publish("/chats", params[:txt])
    render :text => "OK"
  end
end