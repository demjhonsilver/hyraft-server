# hyraft-server/lib/hyraft/server/middleware/web_logger.rb
module Hyraft
  module Server
    class WebLogger
    COLORS = {
        reset: "\e[0m",
        blue: "\e[34m",
        cyan: "\e[36m",
        green: "\e[32m",
        yellow: "\e[33m", 
        light_red: "\033[91m",      # Add light red for web
        navy_blue: "\033[38;2;0;0;128m",  # Navy blue (using RGB)
        red: "\e[31m",
        magenta: "\e[35m"
    }

    def initialize(app)
        @app = app
    end

    def call(env)
        start_time = Time.now
        status, headers, response = @app.call(env)
        end_time = Time.now

        duration_ms = ((end_time - start_time) * 1000).round(2)
        content_length = headers['Content-Length'] || response_body_length(response)
        
        # Convert bytes to KB
        content_length_kb = if content_length.is_a?(Numeric)
                            "#{(content_length / 1024.0).round(2)} KB"
                          else
                            content_length
                          end
        
        path = env['PATH_INFO']
        method = env['REQUEST_METHOD']
        status_code = status.to_i

        # Method-specific colors
        method_color = case method
                    when 'GET' then :green
                    when 'POST' then :blue
                    when 'PUT', 'PATCH' then :cyan
                    when 'DELETE' then :red
                    else :yellow
                    end

        # Status-specific colors
        status_color = case status_code
                    when 200..299 then :green
                    when 300..399 then :cyan
                    when 400..499 then :yellow
                    when 500..599 then :red
                    else :magenta
                    end

        puts "#{COLORS[method_color]}#{method}#{COLORS[:reset]} #{path} → #{COLORS[status_color]}#{status_code}#{COLORS[:reset]} | #{duration_ms}ms | #{content_length_kb}"

        [status, headers, response]
    end

    private

    def response_body_length(response)
        if response.respond_to?(:each)
        total = 0
        response.each { |part| total += part.bytesize }
        total
        elsif response.respond_to?(:to_path) && File.file?(response.to_path)
        File.size(response.to_path)
        else
        'unknown'
        end
    rescue
        'unknown'
    end
    end
  end
end

::WebLogger = Hyraft::Server::WebLogger unless defined?(::WebLogger)