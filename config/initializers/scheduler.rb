require 'rufus-scheduler'

scheduler = Rufus::Scheduler::singleton

scheduler.every '1w' do
#scheduler.every '1m' do
	#rake "progressmail_sender"
	#user=User.last
	User.all.each do |user|
		ProgressMailer.send_progress(user).deliver_now
	end
end