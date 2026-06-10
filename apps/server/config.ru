require_relative "app/app"
require_relative "app/middleware/request_logger"
require_relative "app/middleware/cors"

use RequestLoggerMiddleware
use CorsMiddleware

map "/" do
  run App
end
