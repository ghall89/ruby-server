# frozen_string_literal: true

class App
  post "/replies" do
    reply = Reply.create(current_user.id, params[:post_id], params[:parent_id].to_s.empty? ? nil : params[:parent_id], params[:body])
    halt 201, reply.to_h.to_json
  end

  patch "/replies/:id" do
    require_auth
    Reply.update(params[:id], params[:body])
    Reply.find(params[:id]).to_h.to_json
  end

  delete "/replies/:id" do
    require_auth
    Reply.delete(params[:id])
    status 204
  end
end
