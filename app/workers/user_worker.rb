class UserWorker
	include Sidekiq::Worker
	sidekiq_options retry: false
	
	def perform(id)
		logged_user = User.find(id)
		UserMailer.with(user: logged_user).send_mail(logged_user).deliver
		# UserMailer.with(user: logged_user).send_mail.deliver
	end
end