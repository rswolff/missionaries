module MissionariesHelper
  def events(state)
    case state
    when "awaiting_call"
      link_to "set apart"
    when "serving"
      link_to "release" #, release_missionary_path
    end
  end
  
  def disabled?
    @missionary.mission ? false : true
  end
  
end
