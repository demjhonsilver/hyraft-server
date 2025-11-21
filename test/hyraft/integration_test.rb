# frozen_string_literal: true

require "test_helper"
require "open3"

class Hyraft::IntegrationTest < Minitest::Test
  def test_cli_help_command
    output, _status = Open3.capture2e("bundle exec bin/hyraft-server server-help")
    assert_includes output, "hyraft-server server"
  end

  def test_cli_invalid_command
    output, _status = Open3.capture2e("bundle exec bin/hyraft-server invalid_command")
    assert_includes output, "hyraft-server server"
  end
end