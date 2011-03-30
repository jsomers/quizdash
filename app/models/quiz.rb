class Quiz < ActiveRecord::Base
  has_many :questions, :dependent => :destroy
  has_and_belongs_to_many :categories
  has_many :dashes
  
  accepts_nested_attributes_for :questions, :allow_destroy => true

  validates_presence_of :title
  
  before_save :prune_empty_questions, :validate_number_of_questions

  def self.popular(threshold=-1)
    Quiz.where(["play_count > ?", threshold]).order("play_count DESC")
  end
  
  def prune_empty_questions
    self.questions = self.questions.reject {|q| q.prompt.empty?}
  end
  
  def validate_number_of_questions
    if self.questions.length < 10
      self.errors.add_to_base("Must have at least 10 questions")
    end
  end
  
  def random_questions(n)
    self.questions.sort_by { rand }.first(n).sort {|a, b| a.id <=> b.id}
  end
  
  def self.attach_csv_questions(params, file)
    require 'csv'
    i = params[:questions_attributes].keys.collect {|k| k.to_i}.max
    CSV.parse(file.read).each do |row|
      i += 1
      params[:questions_attributes][i.to_s] = {"prompt" => row[0], "permissible_answers" => row[1..-1].compact.join("|")}
    end
    return params
  end
  
  def url
    "#{self.id}-#{self.title.downcase.gsub(/[^a-z0-9]/, '-').gsub('--', '-')}"
  end
  
  def update_avg_score
    n = 0
    self.dashes.each {|d| n += d.avg_score} 
    self.avg_score = n / self.dashes.length.to_f
  end
end
