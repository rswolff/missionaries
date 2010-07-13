require 'RedCloth'
class Mission < ActiveRecord::Base
  
  validates_presence_of :name, :address, :country_id
  validates_presence_of :lat, :lng, :unless => Proc.new {new_record?}
  
  geocoded_by :address, :latitude  => :lat, :longitude => :lng
  
  has_many :missionaries
  belongs_to :country
  
  default_scope order("name") 
  
  def mailing_address
    m = "*" + self.name + "*" + "\n" + read_attribute(:address)
    n = RedCloth.new(m).to_html
    n.gsub!(/\r/," ")
    n.gsub!(/\n/," ")
  end
  
end