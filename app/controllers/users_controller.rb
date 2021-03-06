class UsersController < ApplicationController
  def show
    @user = current_user
    
    @bookmarks = current_user.videos

    if @user.token.nil?
      @followers = []
      @following = []
      @repos = []
    else
      conn = Faraday.new('https://api.github.com') do |req|
        req.headers['Authorization'] = @user.token
      end

      response_following = conn.get('/user/following')
      parsed_3 = JSON.parse(response_following.body, symbolize_names: true)
      @following = parsed_3.map do |following_data|
        Following.new(following_data)
      end.first(5)

      response_followers = conn.get('/user/followers')
      parsed_2 = JSON.parse(response_followers.body, symbolize_names: true)
      @followers = parsed_2.map do |follower_data|
        Follower.new(follower_data)
      end.first(5)

      repo_list = conn.get('/user/repos')
      parsed = JSON.parse(repo_list.body, symbolize_names: true)
      @repos = parsed.map do |repo_data|
        Repo.new(repo_data)
      end.first(5)
    end
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    flash[:notice] = "Logged in as #{user.first_name} #{user.last_name}. This account has not yet been activated. Please check your email."
    if user.save
      session[:user_id] = user.id
      redirect_to "/email"
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
