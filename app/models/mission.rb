require 'RedCloth'
class Mission < ActiveRecord::Base
  has_many :missionaries
  
  def mailing_address
    m = self.name + "\n" + read_attribute(:address)
    RedCloth.new(m).to_html
  end
end
