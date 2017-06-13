class NotifyWorker
  include Sidekiq::Worker

  def perform(user_ids, current_user_id, section_id, message_type)
    users = User.where(id: user_ids)
    current_user = User.find(current_user_id)
    section = Section.find(section_id)
    target_url = Rails.application.routes.url_helpers.section_url(section, host: "localhost:5000")
    case message_type.to_sym
    when :modification
      message= {
        icon: current_user.avatar_url,
        title: '新消息提醒',
        body:  "#{current_user.name} 修改了ES",
        target_url: target_url
      }
    when :review
      message= {
        icon: current_user.avatar_url,
        title: '新的评论',
        body:  "#{current_user.name} 评论了ES「#{section.title}」点击查看",
        target_url: target_url
      }
    end
    users.each do |user|
      next if user.subscription.blank?
      Webpush.payload_send webpush_params(user, message)
    end
  end

  private

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

  def fetch_subscription(user)
    if user && user.subscription
      encoded_subscription = user.subscription
    else
     raise "Cannot create notification: no :subscription for user"
    end
    JSON.parse(encoded_subscription).with_indifferent_access
  end

end
