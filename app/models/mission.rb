require 'RedCloth'
class Mission < ActiveRecord::Base
  has_many :missionaries
  belongs_to :country
  
  default_scope order("name") 
  
  def mailing_address
    m = "*" + self.name + "*" + "\n" + read_attribute(:address)
    RedCloth.new(m).to_html
  end
end
