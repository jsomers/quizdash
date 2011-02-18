class Quiz < ActiveRecord::Base
  has_many :questions, :dependent => :destroy
  has_and_belongs_to_many :categories
  
  accepts_nested_attributes_for :questions, :allow_destroy => true
end
