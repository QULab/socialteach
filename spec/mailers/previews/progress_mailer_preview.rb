# Preview all emails at http://localhost:3000/rails/mailers/progress_mailer
class ProgressMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/progress_mailer/send_progress
  def send_progress
  	user = User.last
    ProgressMailer.send_progress(user)
  end

end
