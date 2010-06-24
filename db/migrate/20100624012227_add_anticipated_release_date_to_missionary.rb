class AddAnticipatedReleaseDateToMissionary < ActiveRecord::Migration
  def self.up
    add_column :missionaries, :anticipated_release_date, :date
  end

  def self.down
    remove_column :missionaries, :anticipated_release_date
  end
end
