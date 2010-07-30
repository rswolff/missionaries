class AdminMailer < ActionMailer::Base
  default :from => "scott.wolff@tuscan.ca"
  default :to => "scott.wolff@tuscan.ca"

  def missionary_setting_apart_notice(missionaries)
    @missionaries = missionaries
    mail(:subject => "#{pulralize(@missionaries.count, 'missionary')} report to the MTC on #{mtc_date}")
  end
  
  def missionary_release_notice(missionaries, anticipated_release_date)
    @missionaries = missionaries
    mail(:subject => "Some imortant information regarding your mission application.")
  end
end
