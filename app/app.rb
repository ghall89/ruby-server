require "sinatra"
require "haml"

class App < Sinatra::Base
  get "/" do
    name = params['name'] || "world"
    erb :index, locals: { name: name }
  end
end
