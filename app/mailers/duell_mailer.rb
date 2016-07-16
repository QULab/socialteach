class DuellMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.duell_mailer.send_invite.subject
  #
  def send_invite(inviter, opponent)
    @inviter = inviter
    @opponent = opponent

    mail to: @opponent.email, subject: "#{@inviter.username} invites your to a quiz!"
  end
end
