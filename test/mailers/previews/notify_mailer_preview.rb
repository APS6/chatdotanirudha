# Preview all emails at http://localhost:3000/rails/mailers/notify_mailer
class NotifyMailerPreview < ActionMailer::Preview
	def new_message
		user = User.last
    	sender = User.first
    	message = Message.last
		NotifyMailer.new_message(message.body, user, sender)
	end
end
