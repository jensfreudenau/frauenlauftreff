ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :user_name            => "berlinscrolling@gmail.com",
  :password             => "jensBerl#n",
  :authentication       => "plain",
  :enable_starttls_auto => true
}