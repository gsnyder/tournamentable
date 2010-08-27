class CreateMatches < ActiveRecord::Migration
  def self.up
    create_table :matches do |t|
      t.belongs_to :tournament
      t.string :incumbent_id
      t.string :challenger_id

      t.timestamps
    end
  end

  def self.down
    drop_table :matches
  end
end
