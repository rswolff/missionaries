class Missionary < ActiveRecord::Base
  belongs_to :mission
  
  validates_presence_of :courtesy_title, :first_name, :last_name
  
  def full_name
    first_name + " " + last_name
  end
  
  state_machine :state, :initial => :awaiting_call do
    
    event :set_apart do
      transition :awaiting_call => :serving
    end
    
    event :release do 
      transition :serving => :released
    end
    
    event :hold do
      transition :awaiting_call => :hold, :serving => :hold
    end
    
    event :unhold do
      transition :hold => :serving
    end
  end
end
