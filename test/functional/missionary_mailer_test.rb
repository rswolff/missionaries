require 'test_helper'

class MissionaryMailerTest < ActionMailer::TestCase
  test "application_sent_notice" do
    mail = MissionaryMailer.application_sent_notice
    assert_equal "Application sent notice", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "call_receieved_notice" do
    mail = MissionaryMailer.call_receieved_notice
    assert_equal "Call receieved notice", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
