# Preview all emails at http://localhost:3000/rails/mailers/duell_mailer
class DuellMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/duell_mailer/send_invite
  def send_invite
    DuellMailer.send_invite
  end

end
