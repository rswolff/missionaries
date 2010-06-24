class AddUnitIdToMissionary < ActiveRecord::Migration
  def self.up
    add_column :missionaries, :unit_id, :integer
  end

  def self.down
    remove_column :missionaries, :unit_id
  end
end
