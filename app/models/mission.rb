require 'RedCloth'
class Mission < ActiveRecord::Base
  
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