class Dash
  attr_accessor :id, :board
  
  def initialize(id, board=nil)
    @id = id
    @board = (board ? board : [])
    $redis.set self.id, @board.to_json
  end
  
  def save(board)
    @board = board
    $redis.set self.id, board.to_json
    self
  end
  
  def self.find(id)
    (c = $redis.get(id)) ? Dash.new(id, JSON.parse(c)) : nil
  end
end