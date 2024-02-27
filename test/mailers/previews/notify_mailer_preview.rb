# Preview all emails at http://localhost:3000/rails/mailers/notify_mailer
class NotifyMailerPreview < ActionMailer::Preview
	def new_message
		user = User.last
    	sender = User.first
		NotifyMailer.new_message(user, sender)
	end
end
