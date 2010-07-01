class CreateRankings < ActiveRecord::Migration
  def self.up
    create_table :rankings do |t|
      t.references :user
      t.references :tournament
      t.integer :rank
      t.timestamps
    end
  end

  def self.down
    drop_table :rankings
  end
end
