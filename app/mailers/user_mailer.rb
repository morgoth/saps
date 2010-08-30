class UserMailer < ActionMailer::Base
  default :from => "saps.gliwce@gmail.com"

  def password_reset_instructions(user)
    @user = user
    mail(:to => user.email, :subject => t("mailers.user_mailer.password_resets_instructions.subject"))
  end
end
