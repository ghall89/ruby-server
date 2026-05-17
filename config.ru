require_relative "app/app"
require_relative "app/middleware/request_logger"
require "sprockets"
require "dartsass-sprockets"

sprockets = Sprockets::Environment.new
sprockets.append_path File.join(__dir__, "assets/stylesheets")
sprockets.append_path File.join(Gem::Specification.find_by_name("bootstrap").gem_dir, "assets/stylesheets")

use RequestLogger

map "/assets" do
  run sprockets
end

map "/" do
  run App
end
