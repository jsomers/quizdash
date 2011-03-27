class CreateDashes < ActiveRecord::Migration
  def self.up
    create_table :dashes do |t|
      t.text :board
      t.text :players
      t.integer :quiz_id
      t.timestamp :started_at
      t.float :avg_score
      t.timestamps
    end
  end

  def self.down
    drop_table :dashes
  end
end
