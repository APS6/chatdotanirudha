class NotifyMailer < ApplicationMailer

	def new_message(message, user, sender)
		@sender =  sender
		@receiver =  user
		@message = message
		mail(to: @receiver.email, subject: "#{@sender.username} sent you a message")
	end
end
