class Person < ActiveRecord::Base
  has_many :missionaries
  
  def full_name
    first_name + " " + last_name
  end
  
  def full_name_with_courtesy_title
    courtesy_title + " " + full_name
  end
end
