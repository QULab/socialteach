class ProgressMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.progress_mailer.send_progress.subject
  #
  def send_progress(user)

  	@user = user

  	@socialp = @user.points(category: "Socialpoints")
  	@learningp = @user.points(category: "Learningpoints")
  	@enrollment_points = @user.course_enrollments.map do |enrollment|
  		@last_week = enrollment.score_points(category: "Levelpoints").where("created_at > ?", 1.week.ago).sum(:num_points)
  		@the_week_before = enrollment.score_points(category: "Levelpoints").where("created_at < ? and created_at > ?", 1.week.ago, 2.week.ago).sum(:num_points)
  		{:enrollment => enrollment, :points =>enrollment.points(category: "Levelpoints"), :last_week => @last_week, :the_week_before => @the_week_before}
  	end

  	#delete all nil hashes
  	@enrollment_points.compact

  	# socialpoints: commenting, voting
  	# learningpoints: user
  	# levelpoints: ´for courseenrollment
  	# Merit::Score::all   gibt alle punkte zuruck, die es gibt.

    mail to: @user.email, subject: "Weekly Progress for #{@user.username}"
  end
end
