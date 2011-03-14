class AddTimeField < ActiveRecord::Migration
  def self.up
    add_column :quizzes, :time_limit, :integer
  end

  def self.down
    remove_column :quizzes, :time_limit
  end
end
