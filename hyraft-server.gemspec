# frozen_string_literal: true

require_relative "lib/hyraft/server/version"

Gem::Specification.new do |spec|
  spec.name = "hyraft-server"
  spec.version = Hyraft::Server::VERSION
  spec.authors = ["Demjhon Silver"]

  spec.summary = "Web server for Hyraft framework"
  spec.description = "Dual-server Hyraft framework with hexagonal architecture, supporting Puma, Thin, Falcon, and Iodine."
  spec.homepage = "https://github.com/demjhonsilver/hyraft-server"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 4.0.0"


  spec.metadata = {
    "homepage_uri"     => "https://github.com/demjhonsilver/hyraft-server",
    "documentation_uri" => "https://www.rubydoc.info/gems/hyraft-server",
    "source_code_uri"  => "https://github.com/demjhonsilver/hyraft-server/tree/main",
    "changelog_uri"    => "https://github.com/demjhonsilver/hyraft-server/blob/main/CHANGELOG.md"
  }

   spec.metadata["rubygems_mfa_required"] = "true"


  spec.files         = Dir["bin/*", "lib/**/*", "README.md", "LICENSE.txt"]
  spec.bindir        = "bin"
  spec.executables   = ["hyraft-server", "hyr-serve", 'hyr']
  spec.require_paths = ["lib"]

  # Runtime dependencies
  spec.add_dependency "rack", "~> 3.2"
  # spec.add_development_dependency "rake", "~> 13.3"
 # spec.add_development_dependency "minitest", "~> 5.26"
end