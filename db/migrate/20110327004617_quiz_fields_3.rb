class QuizFields3 < ActiveRecord::Migration
  def self.up
    add_column :quizzes, :last_played, :datetime
  end

  def self.down
    remove_column :quizzes, :last_played
  end
end
