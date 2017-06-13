module OmniAuth
  module Strategies
    class Qilian < OmniAuth::Strategies::OAuth2
      RAW_INFO_URL = 'api/v3/users/me'
      option :client_options, {:site => "https://forum.qilian.jp"}

      uid { raw_info["user"]["id"] }

      info do
        {
          email: raw_info['user']['email'],
          name: raw_info['user']['name'],
          login: raw_info['user']['login'],
          avatar_url: raw_info['user']['avatar_url']
        }
      end

      extra do
        { raw_info: raw_info }
      end

      def raw_info
        @raw_info ||= JSON.parse(access_token.get(RAW_INFO_URL).response.body)
      end
    end
  end
end
