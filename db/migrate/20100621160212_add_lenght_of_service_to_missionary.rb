class AddLenghtOfServiceToMissionary < ActiveRecord::Migration
  def self.up
    add_column :missionaries, :length_of_service_in_months, :integer
  end

  def self.down
    remove_column :missionaries, :length_of_service_in_months
  end
end
