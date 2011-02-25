class DashesController < ApplicationController
  def get
    d = Dash.find(params[:id]) || Dash.new(params[:id])
    render :json => d
  end
  
  def add_slot
    d = Dash.find(params[:dash_id])
    leaderboard = d.board
    leaderboard << JSON.parse(params[:slot])
    d.save(leaderboard)
    render :json => d
  end
  
  def mark_q
    d = Dash.find(params[:dash_id])
    d.mark_q(params[:quiz_id], params[:plyr], params[:qid])
    Juggernaut.publish("/#{params[:dash_id]}", d.to_json)
    render :text => "OK"
  end
end
