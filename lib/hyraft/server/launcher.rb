# frozen_string_literal: true

require "optparse"

module Hyraft
  module Server
    # Main server launcher for Hyraft framework
    # 
    # Handles starting web and API servers with support for multiple
    # Ruby server backends (Puma, Thin, Falcon, Iodine)
    #
    # == Usage Examples
    #
    #   hyr s thin                              # Start web server with Thin
    #   hyr s thin --api                        # Start API server with Thin  
    #   hyraft-server puma -p 1025              # Start on custom port
    #   hyraft-server falcon --http2            # Start with HTTP/2
    #
    # @example Start a web server
    #   launcher = Hyraft::Server::Launcher.new
    #   launcher.start('thin', [])
    #
    # @example Start an API server
    #   launcher = Hyraft::Server::Launcher.new
    #   launcher.start('puma', ['--api'])
    class Launcher
      # ANSI color codes for terminal output
      COLORS = {
        lime: "\033[92m",
        yellow: "\033[93m",
        light_red: "\033[91m", 
        green: "\e[32m",
        red: "\e[31m",
        reset: "\033[0m"
      }

      # Initialize a new launcher instance
      #
      # @param options [Hash] Configuration options
      # @option options [String] :server Server type (puma, thin, falcon, iodine)
      # @option options [String] :host Host to bind to (default: "localhost")
      # @option options [Integer] :port Web server port (default: 1025)
      # @option options [Integer] :port_api API server port (default: 1126)
      # @option options [String] :rack_socket Rack config file for web server
      # @option options [String] :rack_socket_api Rack config file for API server
      # @option options [Boolean] :http2 Enable HTTP/2 (Falcon only)
      # @option options [Boolean] :http3 Enable HTTP/3 (Falcon only)
      # @option options [Boolean] :api Enable API server mode
      #
      # @example Basic initialization
      #   Launcher.new
      #
      # @example With custom options
      #   Launcher.new(port: 1025, server: 'puma')
      def initialize(options = {})
        @options = {
          server: nil,
          host: "localhost",
          port: 1025,
          port_api: 1126,
          rack_socket: "setup/server/web-server.ru",
          rack_socket_api: "setup/server/api-server.ru",
          http2: false,
          http3: false,
          api: false
        }.merge(options)
      end

      # Start the server with given command and arguments
      #
      # Supports multiple command formats and server types with
      # comprehensive error handling and user feedback.
      #
      # @param cmd [String] Command to execute
      #   - Server name: 'puma', 'thin', 'falcon', 'iodine'
      #   - Action: 'server', 's', 'svr', 'serve', 'server-help', 'server-version'
      # @param args [Array<String>] Command line arguments
      #
      # @return [void]
      #
      # @example Start web server with Thin
      #   start('thin', [])
      #
      # @example Start API server with Puma
      #   start('puma', ['--api'])
      #
      # @example Show help
      #   start('server-help', [])
      #
      # @example Show version  
      #   start('server-version', [])
      #
      # @raise [OptionParser::InvalidOption] When invalid options are provided
      # @raise [OptionParser::MissingArgument] When required arguments are missing
      def start(cmd, args)
        begin
          # Check if command is a direct server name
          if %w[thin puma falcon iodine].include?(cmd)
            @options[:server] = cmd
            parse_server_options!(args)
            launch_server
          else
            case cmd
            when 'server', 's', 'svr', 'serve'
              parse_server_options!(args)
              launch_server
            when 'server-version', 'server-v', 's-v'
              show_version
            when 'server-help', 'server-h', 's-h'
              show_usage
            when nil, ''
              puts "#{COLORS[:yellow]}[!] No command provided. Showing help...#{COLORS[:reset]}"
              show_usage
            else
              puts "#{COLORS[:yellow]}[!] Unknown command: '#{cmd}'. Showing help...#{COLORS[:reset]}"
              show_usage
            end
          end
        rescue OptionParser::InvalidOption, OptionParser::MissingArgument => e
          puts "#{COLORS[:yellow]}[!] #{e.message}#{COLORS[:reset]}"
          puts "#{COLORS[:yellow]}[!] Falling back to help info...#{COLORS[:reset]}"
          show_usage
        rescue => e
          puts "#{COLORS[:yellow]}[!] Unexpected error: #{e.message}#{COLORS[:reset]}"
          puts "#{COLORS[:yellow]}[!] Showing help for reference...#{COLORS[:reset]}"
          show_usage
        end
      end

      # Display comprehensive usage information
      #
      # Shows available commands, options, and examples for the Hyraft server.
      # Includes colorized output when not in test environment.
      #
      # == Command Variants
      #
      # Alias: (or Shortcut)
      #   hyr s [server-name]                        Start web server
      #   hyr s [server-name] --api                  Start API server directly
      #   hyr s-v                                    Show version
      #   hyr s-h                                    Show this help
      #
      # Medium Form:
      #   hyr-serve [server-name]                    Start web server
      #   hyr-serve [server-name] --api              Start API server directly
      #   hyr-serve s-v                              Show version
      #   hyr-serve s-h                              Show this help
      #
      # Full Command:
      #   hyraft-server [server-name] [options]      Start web server
      #   hyraft-server [server-name] --api [options] Start API server directly
      #   hyraft-server server-version               Show version
      #   hyraft-server server-help                  Show this help
      #
      # == Examples
      #
      #   hyr s thin                              # Start web server with Thin
      #   hyr-serve thin                          # Start web server with Thin
      #   hyraft-server thin                      # Start web server with Thin
      #   hyraft-server thin --api                # Start API server with Thin
      #   hyraft-server puma -p 1025              # Start web server on port 1025
      #   hyraft-server puma --port-api 1126      # Start API server on port 1126
      #   hyraft-server falcon --http2            # Start with HTTP/2 (Falcon)
      #   hyraft-server falcon --http3            # Start with HTTP/3 (Falcon)
      #
      # @return [void]
      def show_usage
        title_color   = colorize? ? COLORS[:lime]   : ""
        header_color  = colorize? ? COLORS[:yellow] : ""
        reset_color   = colorize? ? COLORS[:reset]  : ""

        puts "#{title_color}Hyraft Server #{Hyraft::Server::VERSION}#{reset_color}"
        puts "High-performance web server with hexagonal architecture"
        puts ""
        puts "#{header_color}Usage:#{reset_color}"
        puts "  hyraft-server [server-name] [options]"
        puts ""
        puts "#{header_color}Hotkey:#{reset_color}"
        puts "  hyr s [server-name]                        Start web server (legacy)"
        puts "  hyr s [server-name] --api                  Start API server directly"
        puts "  hyr s-v                                    Show version"
        puts "  hyr s-h                                    Show this help"
        puts ""
        puts "#{header_color}Shortkey:#{reset_color}"
        puts "  hyr-serve [server-name]                    Start web server (legacy)"
        puts "  hyr-serve [server-name] --api              Start API server directly"
        puts "  hyr-serve s-v                              Show version"
        puts "  hyr-serve s-h                              Show this help"
        puts ""
        puts "#{header_color}Standard Key:#{reset_color}"
        puts "  hyraft-server [server-name] [options]      Start web server (legacy)"
        puts "  hyraft-server [server-name] --api [options] Start API server directly"
        puts "  hyraft-server server-version               Show version"
        puts "  hyraft-server server-help                  Show this help"
        puts ""
        puts "#{header_color}Servers:#{reset_color} puma, thin, falcon, iodine"
        puts ""
        puts "#{header_color}Options:#{reset_color}"
        puts "  -s, --server SERVER    Server (puma, thin, falcon, iodine)"
        puts "  -b, --bind HOST        Host (default: localhost)"
        puts "  -p, --port PORT        Port (default: 1025)"
        puts "  --port-api PORT        API Port (default: 1126)"
        puts "  -c, --config FILE      Rack config file"
        puts "  --config-api FILE      API Rack config file"
        puts "  --api                  Enable API server"
        puts "  --http2                Enable HTTP/2 (Falcon only)"
        puts "  --http3                Enable HTTP/3 (Falcon only)"
        puts ""
        puts "#{header_color}Examples:#{reset_color}"
        example_color = colorize? ? COLORS[:lime] : ""
        puts "#{example_color}  hyr s thin                              #{reset_color}# Start web server with Thin - Hotkey"
        puts "#{example_color}  hyr-serve thin                          #{reset_color}# Start web server with Thin - Shortkey"
        puts "#{example_color}  hyraft-server thin                      #{reset_color}# Start web server with Thin"
        puts "#{example_color}  hyraft-server thin --api                #{reset_color}# Start API server with Thin"
        puts "#{example_color}  hyraft-server puma -p 1025              #{reset_color}# Start web server on port 1025"
        puts "#{example_color}  hyraft-server falcon --http2            #{reset_color}# Start with HTTP/2 (Falcon)"
        puts "#{example_color}  hyraft-server s thin                    #{reset_color}# Legacy syntax (still works)"
      end

      private

      # Check if terminal output should be colorized
      #
      # @return [Boolean] true if colors should be used
      # @!visibility private
      def colorize?
        ENV["RACK_ENV"] != "test" && ENV["APP_ENV"] != "test"
      end

      # Parse server-specific command line options
      #
      # @param args [Array<String>] Command line arguments
      # @return [void]
      # @!visibility private
      def parse_server_options!(args)
        # Only look for server in args if not already set
        unless @options[:server]
          first_arg = args[0]
          if %w[thin puma falcon iodine].include?(first_arg)
            @options[:server] = args.shift
          end
        end

        OptionParser.new do |opts|
          opts.banner = "Usage: hyraft-server [server] [options]"
          opts.on("-s", "--server SERVER", "Server (puma, thin, falcon, iodine)") { |v| @options[:server] = v }
          opts.on("-b", "--bind HOST", "Host") { |v| @options[:host] = v }
          opts.on("-p", "--port PORT", Integer, "Port") { |v| @options[:port] = v }
          opts.on("--port-api PORT", Integer, "API Port (default: 1126)") { |v| @options[:port_api] = v }
          opts.on("-c", "--config FILE", "Rack config file") { |v| @options[:rack_socket] = v }
          opts.on("--config-api FILE", "API Rack config file") { |v| @options[:rack_socket_api] = v }
          opts.on("--api", "Enable API server") { |v| @options[:api] = v }
          opts.on("--http2", "Enable HTTP/2 (Falcon only)") { |v| @options[:http2] = v }
          opts.on("--http3", "Enable HTTP/3 (Falcon only)") { |v| @options[:http3] = v }
        end.parse!(args)

        unless @options[:server]
          abort "Error: No server specified. Use -s SERVER or provide a server name (puma, thin, falcon, iodine)."
        end
      end

      # Launch the appropriate server (web or API)
      #
      # @return [void]
      # @!visibility private
      def launch_server
        if @options[:api]
          launch_api_server
        else
          launch_web_server
        end
      end

      # Launch web server
      #
      # @return [void]
      # @!visibility private
      def launch_web_server
        puts "#{COLORS[:yellow]}[ WEB ] - Hyraft#{COLORS[:reset]}"
        puts "* Using server: #{@options[:server].capitalize}"
        puts "* Listening on #{COLORS[:yellow]}http://#{@options[:host]}:#{@options[:port]}#{COLORS[:reset]}"

        case @options[:server]
        when "puma"
          exec "bundle exec puma -b tcp://#{@options[:host]}:#{@options[:port]} #{@options[:rack_socket]}"
        when "thin"
          exec "bundle exec thin start -p #{@options[:port]} -R #{@options[:rack_socket]}"
        when "falcon"
          if @options[:http3]
            puts "#{COLORS[:lime]}* HTTP/3 enabled!#{COLORS[:reset]}"
            exec "bundle exec falcon serve --protocol HTTP3 --bind https://#{@options[:host]}:#{@options[:port]} --config #{@options[:rack_socket]}"
          elsif @options[:http2]
            puts "#{COLORS[:lime]}* HTTP/2 enabled!#{COLORS[:reset]}"
            exec "bundle exec falcon serve --protocol HTTP2 --bind http://#{@options[:host]}:#{@options[:port]} --config #{@options[:rack_socket]}"
          else
            exec "bundle exec falcon serve --bind http://#{@options[:host]}:#{@options[:port]} --config #{@options[:rack_socket]}"
          end
        when "iodine"
          exec "bundle exec iodine -p #{@options[:port]} -t 1 -w 1 #{@options[:rack_socket]}"
        else
          abort "Unknown server: #{@options[:server]}"
        end
      end

      # Launch API server
      #
      # @return [void]
      # @!visibility private
      def launch_api_server


        
        puts "#{COLORS[:lime]}[ API ] - Hyraft#{COLORS[:reset]}"
        puts "* Using server: #{@options[:server].capitalize}"
        puts "* Listening on #{COLORS[:lime]}http://#{@options[:host]}:#{@options[:port_api]}#{COLORS[:reset]}"

        case @options[:server]
        when "puma"
          exec "bundle exec puma -b tcp://#{@options[:host]}:#{@options[:port_api]} #{@options[:rack_socket_api]}"
        when "thin"
          exec "bundle exec thin start -p #{@options[:port_api]} -R #{@options[:rack_socket_api]}"
        when "falcon"
          if @options[:http3]
            puts "#{COLORS[:lime]}* HTTP/3 enabled!#{COLORS[:reset]}"
            exec "bundle exec falcon serve --protocol HTTP3 --bind https://#{@options[:host]}:#{@options[:port_api]} --config #{@options[:rack_socket_api]}"
          elsif @options[:http2]
            puts "#{COLORS[:lime]}* HTTP/2 enabled!#{COLORS[:reset]}"
            exec "bundle exec falcon serve --protocol HTTP2 --bind http://#{@options[:host]}:#{@options[:port_api]} --config #{@options[:rack_socket_api]}"
          else
            exec "bundle exec falcon serve --bind http://#{@options[:host]}:#{@options[:port_api]} --config #{@options[:rack_socket_api]}"
          end
        when "iodine"
          exec "bundle exec iodine -p #{@options[:port_api]} -t 1 -w 1 #{@options[:rack_socket_api]}"
        else
          abort "Unknown server: #{@options[:server]}"
        end
      end

      # Show version information
      #
      # @return [void]
      # @!visibility private
      def show_version
        puts "Hyraft Server v#{Hyraft::Server::VERSION}"
      end
    end
  end
end