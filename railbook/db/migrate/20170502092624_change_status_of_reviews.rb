class ChangeStatusOfReviews < ActiveRecord::Migration[5.0]
  def self.up
    change_column :reviews, :status, :integer, :null => false, :default => 0
  end

  def self.down
    change_column :reviews, :status, :integer, :null => true, :default => nil
  end
end
