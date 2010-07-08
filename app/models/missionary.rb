class Missionary < ActiveRecord::Base
  belongs_to :mission
  belongs_to :unit
  belongs_to :set_apart_by, :class_name => "Person" 
  
  validates_presence_of :courtesy_title, :first_name, :last_name, :unit_id
  validates_presence_of :mtc_date, :if => :has_call?
  
  before_save { |missionary| missionary.anticipated_release_date = missionary.mtc_date + missionary.length_of_service_in_months.months if missionary.has_call? }
  
  scope :awaiting_call, lambda {where("state = 'awaiting_call'").order("last_name, first_name").includes(:unit)}
  scope :call_received, lambda {where("state = 'call_received'").order("mtc_date").includes([:mission, :unit])}
  scope :serving,       lambda {where("state = 'serving'").order("anticipated_release_date").includes([:mission, :unit])}
  scope :returned,      lambda {where("state = 'returned'").order("anticipated_release_date DESC")}
  scope :in_unit,       lambda {|unit_id| where(["units.id = ?", unit_id]).includes(:unit)} 
  scope :in_mission,    lambda {|mission_id| where(["mission_id = ?", mission_id])}

  state_machine :state, :initial => :awaiting_call do 
    
    after_transition :on => :receive_call, :do => :receive_call_notice
    
    event :recieve_call do
      transition :awaiting_call => :call_received
    end
    
    event :set_apart do
      transition :call_received => :serving
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
  
  def has_call?
    call_received? || serving? || returned? ? true : false
  end
  
  def application_sent_notice
    MissionaryMailer.application_sent_notice(self).deliver
  end
  
  def receive_call_notice
    MissionaryMailer.call_received_notice(self).deliver
  end
  
  def self.languages
      missionaries = Arel::Table.new(:missionaries)
      missionaries.where('language <> ""').group(missionaries[:language]).order(missionaries[:language]).project(missionaries[:language], missionaries[:id].count).order("count_id DESC").collect {|row| row.tuple}
  end

end