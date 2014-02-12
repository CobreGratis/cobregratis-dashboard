require 'dashing'

configure do
  set :auth_token, ENV['AUTH_TOKEN']
  set :default_dashboard, 'default'

  helpers do
    def protected!
     # Put any authentication code you want in here.
     # This method is run before accessing any resource.
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