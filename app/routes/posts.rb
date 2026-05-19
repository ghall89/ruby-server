# frozen_string_literal: true

class App
  get "/posts" do
    require_auth
    posts = Post.all_by_user_id(current_user.id)
    erb :posts, locals: { posts: posts }
  end

  get "/posts/new" do
    require_auth
    erb :new_post
  end

  get "/posts/:id/edit" do
    require_auth
    post = Post.find(params[:id])
    halt 404 unless post
    erb :edit_post, locals: { post: post }
  end

  get "/posts/:id" do
    require_auth
    post = Post.find(params[:id])
    halt 404 unless post
    poster = User.find(post.user_id)
    erb :post, locals: { post: post, current_user: current_user, poster: poster }
  end

  post "/posts" do
    require_auth
    post = Post.create(current_user.id, params[:title], params[:body])
    redirect "/posts/#{post.id}"
  end

  patch "/posts/:id" do
    require_auth
    Post.update(params[:id], params[:body])
    redirect "/posts/#{params[:id]}"
  end

  delete "/posts/:id" do
    require_auth
    Post.delete(params[:id])
    redirect "/posts"
  end
end
