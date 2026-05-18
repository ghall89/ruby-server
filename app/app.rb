# frozen_string_literal: true

require "sinatra"
require "securerandom"
require_relative "database"
require_relative "models/user"
require_relative "helpers/auth"

class App < Sinatra::Base
  configure do
    enable :sessions
    set :session_secret, ENV.fetch("SESSION_SECRET") { SecureRandom.hex(64) }
  end

  helpers AuthHelpers
end

require_relative "routes/main"
require_relative "routes/auth"
