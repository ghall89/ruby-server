require_relative "app/app"
require_relative "app/middleware/request_logger"

use RequestLogger
run App
