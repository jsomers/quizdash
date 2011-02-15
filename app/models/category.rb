class Category < ActiveRecord::Base
  belongs_to :category, :foreign_key => "parent_id"
  has_many :categories, :foreign_key => "parent_id"
  has_and_belongs_to_many :quizzes
  
  def parent
    self.category
  end
  
  def children
    self.categories
  end
end
