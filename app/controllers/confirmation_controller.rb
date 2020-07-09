class ConfirmationController < ApplicationController

  def show
    user = User.find(params[:id])
    session[:user_id] = user.id
    user.update_attribute(:status, true)
    user.save!
    flash[:success] = "Thank you, your account is now activated"
  end

end
