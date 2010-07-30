namespace :admin
  desc "find missionaries who are two weeks away from reporting to the MTC"
  task :notify_of_reporting_missionaries => :environment do
    @missionaries = Missionary.where("mtc_date BETWEEN '#{Date.today}' AND '#{2.weeks.from_now}' AND mtc_date IS NULL")
    AdminMailer.missionary_setting_apart_notice(@missionaries).deliver if @missionaries.size > 0
  end
end

#query the database and find missionaries who are two weeks from reporting to the MTC

#query the database and find missionaries who are 45 days from returning home

#query the database for returned missionaries and email it to the high council once each quarter