class PlayController < ApplicationController
  def quiz
    @dash = Dash.find(params[:id]) || Dash.new(params[:id])
  end
  
  def msg
    Juggernaut.publish("/chats", params[:txt])
    render :text => "OK"
  end
end