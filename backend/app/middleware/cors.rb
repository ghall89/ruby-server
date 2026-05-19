# frozen_string_literal: true

require "rack/cors"

class CorsMiddleware
  def initialize(app)
    @cors = Rack::Cors.new(app) do
      allow do
        origins "http://localhost:5173"
        resource "*", headers: :any, methods: %i[get post patch delete options], credentials: true
      end
    end
  end

  def call(env)
    @cors.call(env)
  end
end
