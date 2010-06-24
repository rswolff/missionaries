class CreateMissionaries < ActiveRecord::Migration
  def self.up
    create_table :missionaries do |t|
      t.string :courtesy_title
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :mission_id
      t.string :state
      t.date :mtc_date
      t.string :language

      t.timestamps
    end
  end

  def self.down
    drop_table :missionaries
  end
end
