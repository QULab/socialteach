class WeeklyMailerWorker

	#console: bundle exec sidekiq -q weeklymailer

	include Sidekiq::Worker
	include Sidetiq::Schedulable
	sidekiq_options :queue => :remindermailer

	recurrence do
		daily
	end

	def perform
		User.find_each do |user|
			if user.last_sign_in_at < 1.week.ago
				ReminderMailer.send_reminder(user).deliver_now
			end
		end
	end

end