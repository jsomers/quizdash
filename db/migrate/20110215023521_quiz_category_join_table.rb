class QuizCategoryJoinTable < ActiveRecord::Migration
  def self.up
    create_table :categories_quizzes do |t|
      t.integer :category_id
      t.integer :quiz_id
    end
  end

  def self.down
    drop_table :categories_quizzes
  end
end