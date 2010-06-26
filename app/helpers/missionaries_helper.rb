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
  
  def missionary_length_of_service(courtesy_title)
    case courtesy_title
    when "Elder" || "elder"
      "24"
    when "Sister" || "sister"
      "18"
    end
  end
  
end
