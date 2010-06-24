class AddStateToMissionary < ActiveRecord::Migration
  def self.up
    add_column :missionaries, :state, :string
  end

  def self.down
    remove_column :missionaries, :state
  end
end
