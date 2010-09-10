class AddWinnerToMatch < ActiveRecord::Migration
  def self.up
    add_column :matches, :winner, :string
  end

  def self.down
    remove_column :matches, :winner
  end
end
