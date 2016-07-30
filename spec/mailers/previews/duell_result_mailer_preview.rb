# Preview all emails at http://localhost:3000/rails/mailers/duell_result_mailer
class DuellResultMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/duell_result_mailer/send_result
  def send_result
    DuellResultMailer.send_result
  end

end
