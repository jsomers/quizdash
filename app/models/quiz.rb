class Quiz < ActiveRecord::Base
  has_many :questions, :dependent => :destroy
  has_and_belongs_to_many :categories
  
  accepts_nested_attributes_for :questions, :allow_destroy => true

  # Creates object like {"warmth": 1, "climax": 2, "indigo": 3, "liquor": 4}.
  def answer_map(offset=nil)
    map = {}
    self.questions.each_with_index do |q|
      q.permissible_answers.each {|pa| map[pa] = q.id}
    end
    return map
  end
end
