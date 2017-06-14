class WunderlistWorker
  include Sidekiq::Worker

  def perform(user_id, title)
    user = User.find(user_id)
    return if user.wunderlist_token.blank?
    # since we have token already
    client = OAuth2::Client.new("dummy", "dummy")
    token = OAuth2::AccessToken.new(client, "dummy")
    body =  JSON.dump({list_id: user.wunderlist_listId.to_i, title: title})
    response = token.post("https://a.wunderlist.com/api/v1/tasks", body: body, headers: {'X-Access-Token' => user.wunderlist_token, 'X-Client-ID' => user.wunderlistId, 'Content-Type' => 'application/json' })

  end
end
