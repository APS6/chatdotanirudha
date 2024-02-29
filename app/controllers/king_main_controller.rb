class KingMainController < ApplicationController
  before_action :authenticate_user!
  def index
  	if current_user.id != 1 
  		redirect_to root_path, alert: "You are no king"
  	end
  	@users = User.where.not(id: 1).where.not(confirmed_at: nil).order(last_seen: :desc)
  end
end