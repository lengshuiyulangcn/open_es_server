class NotificationsController < ApplicationController

   def create
    Webpush.payload_send webpush_params
    head :ok
   end

  private

  def webpush_params
    subscription_params = fetch_subscription
    message = "Hello world, the time is #{Time.zone.now}"
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

  def fetch_subscription
    encoded_subscription = session.fetch(:subscription) do
      raise "Cannot create notification: no :subscription in params or session"
    end
    JSON.parse(encoded_subscription).with_indifferent_access
  end
end
