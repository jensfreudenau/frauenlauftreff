# Load the rails application
require File.expand_path('../application', __FILE__)
# Initialize the rails application
Frauenlauftreff::Application.initialize!


ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.smtp_settings[:enable_starttls_auto] = false
ActionMailer::Base.smtp_settings = {
  :address  => "smtp.freude-now.de",
  :port  => 25,
  :user_name  => "xa197p1",
  :password  => "ad2miral",
  :authentication  => :login
}