class UserMailer < ActionMailer::Base
  default from: "pieceofmeat@yandex.ru"

  def password_recovery(user)
    @user = user
    mail(:to => user.email, :subject => "Password recovery from skoloneyRta site")
  end
end
