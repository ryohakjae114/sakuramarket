BusinessTime::Config.load("#{Rails.root.join("config/business_time.yml")}")

BusinessTime::Config.work_week = [:mon, :tue, :wed, :thu, :fri]
