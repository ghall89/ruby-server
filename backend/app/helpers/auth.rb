# frozen_string_literal: true

module AuthHelpers
  def current_user
    return @current_user if defined?(@current_user)

    if session[:user_id]
      @current_user = User.find(session[:user_id])
    elsif (token = request.cookies["remember_token"])
      @current_user = User.find_by_remember_token(token)
      session[:user_id] = @current_user.id if @current_user
    end

    @current_user
  end

  def require_auth
    redirect "/login" unless current_user
  end
end
