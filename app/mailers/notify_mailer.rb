class NotifyMailer < ApplicationMailer

	def new_message(user, sender)
		@sender = params[:sender] || sender
		@receiver = params[:user] || user
		mail(to: @receiver.email, subject: "#{@sender.username} sent you a message")
	end
end
