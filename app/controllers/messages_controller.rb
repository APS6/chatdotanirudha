class MessagesController < ApplicationController
	include Pagy::Backend
	before_action :authenticate_user!
	before_action :set_chat_user, only: %i[index create]
  before_action :set_message, only: %i[ edit update destroy ]

  def index
		@pagy, @messages = pagy(Message.where(sender_id: current_user.id, receiver_id: @chat_user_id ).or(Message.where(receiver_id: current_user.id, sender_id: @chat_user_id)).order(id: :desc), items: 15)
    @message = Message.new(receiver_id: @chat_user)
  end

	def create
		@message = current_user.sent_messages.build(message_params)
		@message.receiver_id = @chat_user_id
	    respond_to do |format|
	      if @message.save
	      	format.turbo_stream
	      	format.html { redirect_to messages_path(@chat_user_id)}
	        # format.json { render :index, status: :created, location: @messages }
	      else
	      	format.turbo_stream
	        format.html { render :index, status: :unprocessable_entity }
	        # format.json { render json: @task.errors, status: :unprocessable_entity }
	      end
	    end
	end

	def edit

	end

	def update
		respond_to do |format|
      if @message.sender_id == current_user.id && @message.update(message_params)
      	format.turbo_stream
        format.html { redirect_to messages_path }
        # format.json { render :index, status: :ok, location: @message }
      else
        format.html { render :index, status: :unprocessable_entity }
        # format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
	end

	def destroy
		if @message.sender_id == current_user.id
			@message.destroy!
		end
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
	end

  private
    def set_message
      @message = Message.find(params[:id])
    end

    def set_chat_user 
    	if current_user.id != 1 
    		@chat_user_id = 1
    	else
    		if params[:user_id]
    			@chat_user = User.find_by(id: params[:user_id])
    			@chat_user_id = params[:user_id].to_i
    		else
    			redirect_to king_path
    		end
    	end
    end

    def message_params
      params.require(:message).permit(:body)
    end

end
