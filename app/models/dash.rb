class Dash
  attr_accessor :id, :board
  
  def initialize(id, board=nil)
    @id = id
    @board = (board ? board : [])
    $redis.set self.id, @board.to_json
  end
  
  def save(board)
    self.board = board
    $redis.set self.id, board.to_json
    self
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
    (c = $redis.get(id)) ? Dash.new(id, JSON.parse(c)) : nil
  end
end