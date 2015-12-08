class UsersController < ApplicationController
    before_filter :authenticate_user!

	def index
	    @users = User.all
	end

	def edit
		@user = User.find(params[:id])
	end

  	def send_admin_mail
    	AdminMailer.new_user_waiting_for_approval(self).deliver
  	end

end
