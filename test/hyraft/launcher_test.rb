# frozen_string_literal: true

require "test_helper"

class Hyraft::LauncherTest < Minitest::Test
  def setup
    @launcher = Hyraft::Server::Launcher.new
  end

  def test_default_options
    options = @launcher.instance_variable_get(:@options)
    
    assert_equal "localhost", options[:host]
    assert_equal 1025, options[:port]
    assert_equal "setup/server/web-server.ru", options[:rack_socket]
    refute options[:http2]
    refute options[:http3]
  end

  def test_custom_options
    custom_options = { port: 8080, host: "127.0.0.1", http2: true }
    launcher = Hyraft::Server::Launcher.new(custom_options)
    options = launcher.instance_variable_get(:@options)
    
    assert_equal 8080, options[:port]
    assert_equal "127.0.0.1", options[:host]
    assert options[:http2]
  end

  def test_server_validation
    valid_servers = %w[thin puma falcon iodine passenger]
    valid_servers.each do |server|
      assert_includes valid_servers, server
    end
  end

  def test_usage_output
    output = capture_io { @launcher.send(:show_usage) }.join
    assert_match(/Usage:/, output)
    assert_match(/hyraft-server server/, output)
  end
end