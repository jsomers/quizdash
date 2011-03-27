class Dash < ActiveRecord::Base
  belongs_to :quiz
  
  serialize :board
  serialize :players
  
  before_save :calculate_avg_score
  
  after_save :update_quiz_metadata
  
  def calculate_avg_score
    s = 0
    self.board.each do |b|
      pointices = b[1]
      s += pointices.count(1) / pointices.length.to_f
    end
    self.avg_score = s / self.board.length
  end
  
  def update_quiz_metadata
    q = Quiz.find(self.quiz_id)
    q.play_count += 1
    q.update_avg_score
    q.last_played = DateTime.now
    best_dash_length_in_seconds = self.players.collect {|p| if p[1] then Time.parse(p[1]) - self.started_at else q.time_limit * 60 end}.sort.first
    if q.fastest_time.nil? or best_dash_length_in_seconds < q.fastest_time
      q.fastest_time = best_dash_length_in_seconds
    end
    q.save(false)
  end
end
