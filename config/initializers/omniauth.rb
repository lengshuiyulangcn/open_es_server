require File.expand_path('../../../lib/omniauth/strategies/qilian', __FILE__)
require File.expand_path('../../../lib/omniauth/strategies/wunderlist', __FILE__)
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :qilian, ENV['QILIAN_KEY'], ENV['QILIAN_SECRET'], :callback_path => '/auth/qilian/callback'
  provider :wunderlist, ENV['WUNDERLIST_KEY'], ENV['WUNDERLIST_SECRET'], :callback_path => '/auth/wunderlist/callback'
end
