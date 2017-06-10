class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :webpush_params

  private

  def current_user
    return unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end

  def logged_in?
    !!session[:user_id]
  end

  def authenticate
    return if logged_in?
    redirect_to root_path, alert: '请先登录'
  end
  
  def fetch_subscription(user)
    if user && user.subscription
      encoded_subscription = user.subscription
    else
     raise "Cannot create notification: no :subscription for user"
    end
    JSON.parse(encoded_subscription).with_indifferent_access
  end

    ## message format
    #message: {
    #    icon: 'https://example.com/images/demos/icon-512x512.png',
    #    title: title,
    #    body: body,
    #    target_url: target_url
    #}
  def webpush_params(user,message)
    subscription_params = fetch_subscription(user)
    message = message.to_json
    endpoint = subscription_params[:endpoint]
    p256dh = subscription_params.dig(:keys, :p256dh)
    auth = subscription_params.dig(:keys, :auth)
    vapid = {
    subject: 'gyorou@tjjtds.me',
    public_key: ENV['WEB_PUSH_VAPID_PUBLIC_KEY'],
    private_key: ENV['WEB_PUSH_VAPID_PRIVATE_KEY']
    }
    { message: message, endpoint: endpoint, p256dh: p256dh, auth: auth, vapid: vapid }
  end
end
