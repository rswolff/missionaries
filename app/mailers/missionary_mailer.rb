class MissionaryMailer < ActionMailer::Base
  default :from => "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.actionmailer.missionary_mailer.application_sent_notice.subject
  #
  def application_sent_notice
    @greeting = "Hi"

    mail :to => "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.actionmailer.missionary_mailer.call_receieved_notice.subject
  #
  def call_receieved_notice
    @greeting = "Hi"

    mail :to => "to@example.org"
  end
end
