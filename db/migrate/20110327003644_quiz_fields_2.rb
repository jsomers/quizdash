class QuizFields2 < ActiveRecord::Migration
  def self.up
    add_column :quizzes, :play_count, :integer
    add_column :quizzes, :avg_score, :float
    add_column :quizzes, :fastest_time, :float
  end

  def self.down
    remove_column :quizzes, :play_count
    remove_column :quizzes, :avg_score
    remove_column :quizzes, :fastest_time
  end
end
