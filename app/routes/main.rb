# frozen_string_literal: true

class App
  get "/" do
    require_auth
    erb :index, locals: { username: current_user.username }
  end
end
