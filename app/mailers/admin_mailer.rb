class AdminMailer < ApplicationMailer
	default from: 'notifications@chicarello.com'
 
  def new_user_waiting_for_approval(user)
    @user = user
    mail to: user.email, subject: "Account activation"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Password reset"
  end
end