class UserMailer < ActionMailer::Base
  default from: "admin@codingways.com.ar"

  def welcome(email)
    mail(to: email, subject: "Bienvenido")
  end
end
