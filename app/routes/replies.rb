# frozen_string_literal: true

class App
  get "/replies/:id" do
    require_auth
    reply = Reply.find(params[:id])
    halt 404 unless reply
    poster = User.find(post.user_id)
    erb :post, locals: { reply: reply, current_user: current_user, poster: poster }
  end

  post "/replies" do
    require_auth
    post = Reply.create(current_user.id, params[:title], params[:body])
    redirect "/replies/#{post.id}"
  end

  patch "/replies/:id" do
    require_auth
    Reply.update(params[:id], params[:body])
    redirect "/replies/#{params[:id]}"
  end

  delete "/replies/:id" do
    require_auth
    Reply.delete(params[:id])
    redirect "/replies"
  end
end
