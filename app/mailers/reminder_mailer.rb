class ReminderMailer < ApplicationMailer

  def send_reminder(user)

    @user = user

    mail to: @user.email, subject: "Socialteach misses you!"
  end
end
