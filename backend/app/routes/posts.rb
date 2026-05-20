# frozen_string_literal: true

class App
  get "/posts" do
    Post.all.map(&:to_h).to_json
  end

  get "/posts/:id" do
    post = Post.find(params[:id])
    halt 404, { error: "Not found" }.to_json unless post
    poster = User.find(post.user_id)
    replies = Reply.all_by_post_id(post.id)
    { post: post.to_h, poster: poster.to_h, replies: replies }.to_json
  end

  post "/posts" do
    require_auth
    post = Post.create(current_user.id, params[:title], params[:body])
    halt 201, post.to_h.to_json
  end

  patch "/posts/:id" do
    require_auth
    Post.update(params[:id], params[:title], params[:body])
    Post.find(params[:id]).to_h.to_json
  end

  delete "/posts/:id" do
    require_auth
    Post.delete(params[:id])
    status 204
  end
end
