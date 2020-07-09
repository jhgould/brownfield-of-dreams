class InvitesController < ApplicationController

  def new
    # recipient = GithubService()
    
  end
  
  def create
    require 'pry'; binding.pry
    github_handle = params["GitHub Handle:"]
  end

end