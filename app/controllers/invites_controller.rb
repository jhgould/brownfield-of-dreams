class InvitesController < ApplicationController

  def new
  end
  
  def create
    require 'pry'; binding.pry
    recipient = GithubService.new(current_user).github_handle(params["github_handle"])
    if !recipient && recipient[:email] == nil
      redirect_to '/dashboard'
      flash[:error] = "The Github user you selected doesn't have an email address associated with their account."
    elsif recipient[:email]
      redirect_to '/dashboard'
      flash[:success] = "Successfully sent invite!"
    end
  end

end