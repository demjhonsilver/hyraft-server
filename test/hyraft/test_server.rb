# frozen_string_literal: true

require "test_helper"

class Hyraft::TestServer < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Hyraft::Server::VERSION
  end

  def test_launcher_initialization
    launcher = Hyraft::Server::Launcher.new
    assert_instance_of Hyraft::Server::Launcher, launcher
  end
end