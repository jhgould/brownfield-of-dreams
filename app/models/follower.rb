class Follower
  
  attr_reader :login,
              :url
  def initialize(follower_data)
    @login = follower_data[:login]
    @url = follower_data[:html_url]
  end

  def user_exists?
    User.find_by(login: @login)
  end

end

# TODO follower and following can be GithubUser for future refactor
