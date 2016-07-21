class WeeklyMailerWorker

	#console: bundle exec sidekiq -q weeklymailer

	include Sidekiq::Worker
	include Sidetiq::Schedulable
	sidekiq_options :queue => :weeklymailer

	recurrence do
		weekly
	end

	def perform
		User.find_each do |user|
			ProgressMailer.send_progress(user).deliver_now
		end
	end

end