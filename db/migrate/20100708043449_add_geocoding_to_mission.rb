class AddGeocodingToMission < ActiveRecord::Migration
  def self.up
    add_column :missions, :lat, :float
    add_column :missions, :lng, :float
  end

  def self.down
    remove_column :missions, :lng
    remove_column :missions, :lat
  end
end
