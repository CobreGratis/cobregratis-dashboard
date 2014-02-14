require 'dashing'

configure do
  set :auth_token, ENV['AUTH_TOKEN']
  set :default_dashboard, 'default'

  helpers do
    def protected!
      unless authorized? or ENV['HTTP_BASIC_PASSWORD'].nil?
        response['WWW-Authenticate'] = %(Basic realm="Restricted Area")
        throw(:halt, [401, "Not authorized\n"])
      end
    end

    def authorized?
      @auth ||=  Rack::Auth::Basic::Request.new(request.env)
      @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == ['cobregratis', ENV['HTTP_BASIC_PASSWORD']]
    end
  end
end

# Run heroku config:add CANONICAL_HOST=yourdomain.com
# For more information, see: https://github.com/tylerhunt/rack-canonical-host#usage
require 'rack-canonical-host'
use Rack::CanonicalHost, ENV['CANONICAL_HOST'] if ENV['CANONICAL_HOST']

map Sinatra::Application.assets_prefix do
  run Sinatra::Application.sprockets
end

run Sinatra::Application