class Question < ActiveRecord::Base
  belongs_to :quiz

  serialize :permissible_answers
  
  before_save :listify_permissibles
  
  def listify_permissibles
    self.permissible_answers = self.permissible_answers.split(",").collect {|pa| pa.strip}
  end
end
