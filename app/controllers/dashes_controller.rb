class DashesController < ApplicationController
  def get
    d = $redis.get(params[:id]) || new_dash(params[:id], params[:quiz_id])
    render :json => d
  end
  
  def add_slot
    d = add_slot_to_dash(params[:dash_id], JSON.parse(params[:slot]))
    Juggernaut.publish("/#{params[:dash_id]}", d)
    render :text => "OK"
  end
  
  def mark_q
    d = Dash.find(params[:dash_id])
    d.mark_q(params[:quiz_id], params[:plyr], params[:qid])
    Juggernaut.publish("/#{params[:dash_id]}", d.to_json)
    render :text => "OK"
  end
  
  def start_countdown
    msg = {"msg" => "start_countdown"}
    Juggernaut.publish("/#{params[:dash_id]}", msg.to_json)
    render :text => "OK"
  end
  
  private
  
  def new_dash(id, quiz_id)
    obj = {"quiz_id" => quiz_id, "board" => [], "players" => [], "ready" => []}.to_json
    $redis.set id, obj
    return obj
  end
  
  def add_slot_to_dash(id, slot)
    obj = JSON.parse($redis.get id)
    obj["board"] << slot
    obj["players"] << slot[0]
    $redis.set id, obj.to_json
    return obj.to_json
  end
end
