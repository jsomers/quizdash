class Quiz < ActiveRecord::Base
  has_many :questions, :dependent => :destroy
  has_and_belongs_to_many :categories
  
  accepts_nested_attributes_for :questions, :allow_destroy => true
  
  validates_inclusion_of :time_limit, :in => 1..15
  validates_presence_of :title

  # Creates object like {"warmth": 1, "climax": 2, "indigo": 3, "liquor": 4}.
  def answer_map(offset=nil)
    map = {}
    self.questions.each_with_index do |q|
      q.permissible_answers.each {|pa| map[pa] = q.id}
    end
    return map
  end
  
  def add_questions_from_file(file)
    require 'csv'
    CSV.parse(file.read).each do |row|
      self.questions.create(:prompt => row[0], :permissible_answers => row[1..-1])
    end
  end
end
