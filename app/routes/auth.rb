# frozen_string_literal: true

class App
  get "/login" do
    redirect "/" if current_user
    erb :login, locals: { error: nil }
  end

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

      redirect "/"
    else
      erb :login, locals: { error: "Invalid username or password" }
    end
  end

  get "/signup" do
    redirect "/" if current_user
    erb :signup, locals: { error: nil }
  end

  post "/signup" do
    username = params[:username].to_s.strip
    password = params[:password].to_s

    return erb :signup, locals: { error: "Username and password are required" } if username.empty? || password.empty?

    return erb :signup, locals: { error: "Password must be at least 8 characters" } if password.length < 8

    return erb :signup, locals: { error: "Username already taken" } if User.find_by_username(username)

    user = User.create(username, password)
    session[:user_id] = user.id
    redirect "/"
  end

  post "/logout" do
    if (token = request.cookies["remember_token"])
      user = User.find_by_remember_token(token)
      user&.clear_remember_token
      response.delete_cookie("remember_token", path: "/")
    end
    session.clear
    redirect "/login"
  end
end
