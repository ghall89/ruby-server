# frozen_string_literal: true

class App
  post "/login" do
    user = User.find_by_username(params[:username].to_s.strip)

    if user&.authenticate(params[:password].to_s)
      session[:user_id] = user.id

      if params[:remember_me] == "1"
        token = SecureRandom.hex(32)
        user.save_remember_token(token)
        response.set_cookie("remember_token", {
                              value: token,
                              expires: Time.now + (30 * 24 * 60 * 60),
                              httponly: true,
                              path: "/"
                            })
      end

      user.to_json
    else
      halt 401, { error: "Invalid username or password" }.to_json
    end
  end

  post "/signup" do
    username = params[:username].to_s.strip
    password = params[:password].to_s

    return halt 422, { error: "Username and password are required" }.to_json if username.empty? || password.empty?

    return halt 422, { error: "Password must be at least 8 characters" }.to_json if password.length < 8

    return halt 422, { error: "Username already taken" }.to_json if User.find_by_username(username)

    user = User.create(username, password)
    session[:user_id] = user.id
    user.to_json
  end

  post "/logout" do
    if (token = request.cookies["remember_token"])
      user = User.find_by_remember_token(token)
      user&.clear_remember_token
      response.delete_cookie("remember_token", path: "/")
    end
    session.clear
    status 204
  end
end
