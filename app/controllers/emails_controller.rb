class EmailsController < ApplicationController

  def show
    redirect_to root_path unless logged_in?
  end

  def create
    # recipient = current_user
    recipient = User.find(session[:user_id])
    EmailConfirmationMailer.inform(recipient).deliver_now
    # flash[:notice] = "Logged in as #{@user.first_name}. This account has not yet been activated. Please check your email."
    redirect_to '/dashboard'
  end

  def update
    user = current_user.update_attribute(:status, true)
    user.save!
    flash[:success] = "Thank you, your account is now activated"
    redirect_to "/dashboard"
  end

end
