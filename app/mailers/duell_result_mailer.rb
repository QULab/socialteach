class DuellResultMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.duell_result_mailer.send_result.subject
  #
  def send_result(user, opponent, flag)
    @user = user
    @opponent = opponent
    #flag == true if winning the duell
    @flag = flag

    mail to: @user.email, subject: "Your duellresults on socialteach!"
  end
end
