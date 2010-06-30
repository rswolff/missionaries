class DropCountryCode < ActiveRecord::Migration
  def self.up
    remove_column :missions, :country_code
  end

  def self.down
    add_column :missions, :country_code, :string
  end
end
