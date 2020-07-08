class SessionsController < ApplicationController
  protect_from_forgery :except => [:login]

  def new
    @user = User.new
  end

  def login
    current_user.update!(token: "token #{token}")
    redirect_to dashboard_path
  end


  def create

    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Looks like your email or password is invalid'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end


  private
    def token
      request.env['omniauth.auth']['credentials']['token']
    end


end
