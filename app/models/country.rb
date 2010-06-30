class Country < ActiveRecord::Base
  has_many :missions
  
  def self.country_codes
    countries = Table(:countries)
    missions = Table(:missions)
    missionaries = Table(:missionaries)
    
    missions.select("DISTINCT(country_code)") #.join(missions).on(countries[:id].eq(missions[:country_id])).join(missionaries).on(missionaries[:mission_id].eq(missions[:id])).project(countries[:iso_3166_1_2])
    
  end
end
