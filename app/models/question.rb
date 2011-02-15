class Question < ActiveRecord::Base
  belongs_to :quiz

  serialize :permissible_answers
end
