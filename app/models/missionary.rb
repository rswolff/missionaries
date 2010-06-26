class Missionary < ActiveRecord::Base
  belongs_to :mission
  belongs_to :unit
  belongs_to :set_apart_by, :class_name => "Person" 
  
  validates_presence_of :courtesy_title, :first_name, :last_name, :unit_id
  
  scope :awaiting_call, lambda {where("state = 'awaiting_call'").order("last_name, first_name").includes(:unit)}
  scope :call_received, lambda {where("state = 'call_received'").order("mtc_date").includes([:mission, :unit])}
  scope :serving,       lambda {where("state = 'serving'").order("anticipated_release_date").includes([:mission, :unit])}
  scope :active,        lambda {where}
  scope :returned,      lambda {where("state = 'returned'").order("anticipated_release_date DESC")}
  scope :in_unit,       lambda {|unit_id, state| where(["missionaries.state = ? AND units.id = ?", state, unit_id]).joins(:unit)}  
  
  state_machine :state, :initial => :awaiting_call do
    
    event :recieve_call do
      transition :awaiting_call => :call_recieved
    end
    
    event :set_apart do
      transition :call_recieved => :serving
    end
    
    event :release do 
      transition :serving => :returned
    end
    
    event :hold do
      transition :awaiting_call => :hold, :serving => :hold
    end
    
    event :unhold do
      transition :hold => :serving
    end
  end
  
  def full_name
    first_name + " " + last_name
  end
  
  def full_name_with_courtesy_title
    courtesy_title + " " + full_name
  end
  
  def length_of_service
    if mtc_date && serving?
      (Date.today - mtc_date).to_i
    else
      "N/A"
    end
  end
  
end
