class MissionaryMailer < ActionMailer::Base
  default :from => "scott.wolff@tuscan.ca"

  def application_sent_notice(missionary)
    @missionary = missionary

    mail(:to => missionary.email, :subject => "Some imortant information regarding your mission application.")
  end

  def call_receieved_notice
    @greeting = "Hi"

    mail :to => "to@example.org"
  end
end
