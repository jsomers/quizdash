class QuizFields < ActiveRecord::Migration
  def self.up
    rename_column :quizzes, :instructions, :description
  end

  def self.down
    rename_column :quizzes, :description, :instructions
  end
end
