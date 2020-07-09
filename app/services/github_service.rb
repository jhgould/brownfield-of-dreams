class GithubService

  def initialize(user)
    @user = user
  end

  def github_handle(handle)
    res = get_json("https://api.github.com/users/#{handle}", {})
    if res[:id]
      res
    else
      false
    end
  end

  def get_email(handle)
    user_email_info = user_conn(handle).get()
    JSON.parse(user_email_info.body, symbolize_names: true)
  end

  private

  def get_json(url, params)
    response = conn.get(url, params)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new('https://api.github.com') do |req|
      req.headers['Authorization'] = @user.token
    end 
  end

  def handle_conn(handle)
    Faraday.new("https://api.github.com/users/#{handle}")
  end
end
