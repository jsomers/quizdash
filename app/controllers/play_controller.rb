class PlayController < ApplicationController
  def quiz
  end
  
  def msg
    Juggernaut.publish("/chats", params[:txt])
    render :text => "OK"
  end
end