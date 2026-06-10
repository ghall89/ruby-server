# frozen_string_literal: true

require "sinatra"
require "securerandom"
require_relative "database"
require_relative "models/user"
require_relative "models/post"
require_relative "models/reply"
require_relative "helpers/auth"

class App < Sinatra::Base
  configure do
    enable :sessions
    set :session_secret, ENV.fetch("SESSION_SECRET") { SecureRandom.hex(64) }
    set :bind, '0.0.0.0'
    set :port, ENV.fetch("PORT")
  end

  before do
    content_type :json
  end

  helpers AuthHelpers
end

require_relative "routes/health"
require_relative "routes/auth"
require_relative "routes/posts"
require_relative "routes/replies"
