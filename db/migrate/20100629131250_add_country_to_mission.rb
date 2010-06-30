class AddCountryToMission < ActiveRecord::Migration
  def self.up
    add_column :missions, :country_code, :string
  end

  def self.down
    remove_column :missions, :country_code
  end
end
