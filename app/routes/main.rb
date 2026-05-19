# frozen_string_literal: true

class App
  get "/" do
    require_auth
    posts = Post.all
    erb :index, locals: { posts: posts }
  end
end
