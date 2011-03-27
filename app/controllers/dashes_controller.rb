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
  
  def activate_player
    d = make_player_ready(params[:dash_id], params[:player])
    msg = {"msg" => "player_ready", "player_ready" => params[:player]}
    Juggernaut.publish("/#{params[:dash_id]}", msg.to_json)
    if (pl = JSON.parse(d)["players"].length) >= 2 and JSON.parse(d)["ready"].length == pl
      msg = {"msg" => "start_countdown"}
      start_dash(params[:dash_id])
      Juggernaut.publish("/#{params[:dash_id]}", msg.to_json)
    end
    render :text => "OK"
  end
  
  def start_countdown
    msg = {"msg" => "start_countdown"}
    Juggernaut.publish("/#{params[:dash_id]}", msg.to_json)
    render :text => "OK"
  end
  
  def mark_q
    d = mark_question(params[:dash_id], params[:quiz_id], params[:plyr], params[:qid])
    Juggernaut.publish("/#{params[:dash_id]}", d)
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
    if !obj["board"].include? slot then obj["board"] << slot end
    if !obj["players"].include? slot[0] then obj["players"] << slot[0] end
    $redis.set id, obj.to_json
    return obj.to_json
  end
  
  def make_player_ready(id, player)
    obj = JSON.parse($redis.get id)
    if !obj["ready"].include? player then obj["ready"] << player end
    $redis.set id, obj.to_json
    return obj.to_json
  end
  
  def start_dash(id)
    obj = JSON.parse($redis.get id)
    obj["started_at"] = "true"
    $redis.set id, obj.to_json
    return obj.to_json
  end
  
  def mark_question(dash_id, quiz_id, handle, question_id)
    # Takes the leaderboard, finds the player specified by the given handle, and
    # uses the quiz & question_id to find and mark the appropriate question.
    quiz, question = Quiz.find(quiz_id), Question.find(question_id)
    i = quiz.questions.index(question)
    obj = JSON.parse($redis.get dash_id)
    board = obj["board"]
    board.select {|entry| entry.first == handle}[0].last[i] = 1
    obj["board"] = board.sort {|a, b| b[1].count(1) <=> a[1].count(1)}
    $redis.set dash_id, obj.to_json
    return obj.to_json
  end
end
