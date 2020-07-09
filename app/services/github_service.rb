class GithubService

  def github_handle(handle, token)
    headers = { Authorization: "token #{token}"}
    res = get_json("https://api.github.com/users/#{handle}", {}, headers)
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
