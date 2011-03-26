class Question < ActiveRecord::Base
  belongs_to :quiz

  serialize :permissible_answers
  
  before_save :listify_permissibles
  
  def listify_permissibles
    if self.permissible_answers.is_a? String
      self.permissible_answers = self.permissible_answers.split(",").collect {|pa| pa.strip}
    end
  end
end
