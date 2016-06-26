class ProgressMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.progress_mailer.send_progress.subject
  #
  def send_progress(user)

  	@user = user

    mail to: @user.email, subject: "Weekly Progress for #{@user.username}"
  end
end
