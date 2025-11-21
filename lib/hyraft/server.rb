# frozen_string_literal: true

require_relative "server/version"


module Hyraft
  module Server
    class Error < StandardError; end
    # Your code goes here...

   
  end
end

require_relative 'server/middleware/web_logger'
require_relative 'server/middleware/api_logger'
