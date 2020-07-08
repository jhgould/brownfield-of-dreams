class EmailsController < ApplicationController

  def show
    redirect_to root_path unless logged_in?
  end

  def create
    recipient = User.find(session[:user_id])
    EmailConfirmationMailer.inform(recipient).deliver_now
    binding.pry
    # flash[:notice] = "Logged in as #{@user.first_name}. This account has not yet been activated. Please check your email."
    redirect_to '/dashboard'
  end

end
