class PatchCategoryQuizJoinTable < ActiveRecord::Migration
  def self.up
    remove_column :categories_quizzes, :id
  end

  def self.down
    add_column :categories_quizzes, :id, :primary_key => true
  end
end
