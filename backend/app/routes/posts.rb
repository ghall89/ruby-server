# frozen_string_literal: true

class App
  get "/posts/:id" do
    require_auth
    post = Post.find(params[:id])
    halt 404 unless post
    poster = User.find(post.user_id)
    replies = Reply.all_by_post_id(post.id)
    erb :post, locals: {
      post: post,
      replies: replies,
      current_user: current_user,
      poster: poster
    }
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
