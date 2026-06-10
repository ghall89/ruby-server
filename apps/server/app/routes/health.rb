# frozen_string_literal: true

class App
  get "/health" do
    { status: "OK"}.to_json
  end
end
