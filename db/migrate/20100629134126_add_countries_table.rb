class AddCountriesTable < ActiveRecord::Migration
  def self.up
    create_table :countries, :force => true do |t|
      t.string :name
      t.string :iso_3166_1_2
      t.string :iso_3166_1_3
    end
    
    add_column :missions, :country_id, :string
  end

  def self.down
    remove_column :missions, :country_id
    drop_table :countries
  end
end
