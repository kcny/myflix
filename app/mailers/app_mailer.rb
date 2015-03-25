class AppMailer < ActionMailer::Base
  def send_welcome_email(user)
    @user = user
    mail to: user.email, from: "info@myflix.com", subject: "Welcome to the Myflix app!"
  end

  def send_forgot_password(user)
    mail to: user.email, from: "info@myflix.com", subject: "Please reset your password." 
  end
end