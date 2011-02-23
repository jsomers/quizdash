class Dash
  attr_accessor :id, :content
  
  def initialize(id)
    @id = id
    @content = {
      "players" => nil
    }
    $redis.set self.id, content.to_json
  end
  
  def save(content)
    @content = content
    $redis.set self.id, content.to_json
    self
  end
  
  def self.find(id)
    (c = $redis.get(id)) ? Dash.new(id, JSON.parse(c)) : nil
  end
end