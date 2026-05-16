class RequestLogger
  def initialize(app, logger: $stdout)
    @app = app
    @logger = logger
  end

  def call(env)
    started = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    status, headers, body = @app.call(env)
    duration_ms = ((Process.clock_gettime(Process::CLOCK_MONOTONIC) - started) * 1000).round(2)

    @logger.puts "[#{Time.now.strftime('%Y-%m-%d %H:%M:%S')}] #{env['REQUEST_METHOD']} #{env['PATH_INFO']} -> #{status} (#{duration_ms}ms)"

    [status, headers, body]
  end
end
