class AddReleaseInfoToMissionary < ActiveRecord::Migration
  def self.up
    add_column :missionaries, :release_date, :date
    add_column :missionaries, :set_apart_date, :date
    add_column :missionaries, :set_apart_by_id, :integer
  end

  def self.down
    remove_column :missionary, :set_apart_by_id
    remove_column :missionary, :set_apart_date
    remove_column :missionary, :release_date
  end
end
