class DefaultifyQuizFields < ActiveRecord::Migration
  def self.up
    change_column :quizzes, :play_count, :integer, :default => 0
  end

  def self.down
    change_column :quizzes, :play_count, :integer
  end
end
