# frozen_string_literal: true

class App
  get "/" do
    require_auth
    haml :index, locals: { username: current_user.username }
  end
end
