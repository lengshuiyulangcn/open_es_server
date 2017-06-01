require File.expand_path('../../../lib/omniauth/strategies/qilian', __FILE__)
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :qilian, ENV['QILIAN_KEY'], ENV['QILIAN_SECRET'], :callback_path => '/auth/qilian/callback'
end
