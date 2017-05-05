class ChangeReviewsCountToUsers < ActiveRecord::Migration[5.0]
  def self.up
    change_column :users, :reviews_count, :integer, :null => false, :default => 0
  end

  def self.down
    change_column :users, :reviews_count, :integer, :null => true, :default => nil
  end
end
