class PlayController < ApplicationController
  def quiz
    @dash_hash = Digest::MD5.hexdigest(params[:id]).first(10)
    @quiz = Quiz.find(params[:id].split("_").first)
  end
  
  def msg
    Juggernaut.publish("/chats", params[:txt])
    render :text => "OK"
  end
end