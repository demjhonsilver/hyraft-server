# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "hyraft/server"
require "hyraft/server/launcher"

require "minitest/autorun"
require "minitest/pride"