# frozen_string_literal: true

class App
  post "/replies" do
    require_auth
    reply = Reply.create(current_user.id, params[:post_id], params[:parent_id].empty? ? nil : params[:parent_id], params[:body])
    redirect "/posts/#{reply.post_id}"
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
