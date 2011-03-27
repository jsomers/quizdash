class Dash
  attr_accessor :id, :board
  
  def initialize(id, quiz_id=nil, players=nil, ready=nil, board=nil)
    @id = id
    @board = (board ? board : [])
    @quiz_id = quiz_id
    @players = (players ? players : [])
    @ready = (ready ? ready : [])
    $redis.set self.id, {"board" => @board.to_json, "quiz_id" => @quiz_id, "players" => @players.to_json, "ready" => @ready.to_json}
  end
  
  def sort_board
    self.board = self.board.sort {|a, b| b[1].count(1) <=> a[1].count(1)}
  end
  
  def save(board)
    obj = $redis.get self.id
    self.board = board
    self.sort_board
    obj["board"] = board.to_json
    $redis.set self.id, obj
    self
  end
  
  def activate_player(player)
    obj = $redis.get self.id
    self.ready << player
    obj["ready"] = self.ready
    $redis.set self.id, obj
  end
  
  def mark_q(quiz_id, handle, question_id)
    # Takes the leaderboard, finds the player specified by the given handle, and
    # uses the quiz & question_id to find and mark the appropriate question.
    quiz, question = Quiz.find(quiz_id), Question.find(question_id)
    i = quiz.questions.index(question)
    board = self.board
    board.select {|entry| entry.first == handle}[0].last[i] = 1
    self.save(board)
  end
  
  def self.find(id)
    c = $redis.get(id)
    (c ? Dash.new(id, c["quiz_id"], c["players"], c["ready"], c["board"]) : nil)
  end
end