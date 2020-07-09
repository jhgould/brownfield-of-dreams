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
end
