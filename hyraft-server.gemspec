# frozen_string_literal: true

require_relative "lib/hyraft/server/version"

Gem::Specification.new do |spec|
  spec.name = "hyraft-server"
  spec.version = Hyraft::Server::VERSION
  spec.authors = ["Demjhon Silver"]

  spec.summary = "Web server for Hyraft framework"
  spec.description = "Dual-server web stack implementing hexagonal architecture. Supports simultaneous web and API servers across multiple Ruby backends (Puma, Thin, Falcon, Iodine) for the Hyraft platform."
  spec.homepage = "https://github.com/demjhonsilver/hyraft-server"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.4.0"

  # Fix: Remove duplicate homepage assignment
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/demjhonsilver/hyraft-server"
  spec.metadata["changelog_uri"] = "https://github.com/demjhonsilver/hyraft-server/releases"
  spec.metadata["documentation_uri"] = "https://rubydoc.info/gems/hyraft-server"
  spec.metadata["rubygems_mfa_required"] = "true"

  # Add Yard to metadata
  spec.metadata["yard.run"] = "yri" # use yard to generate documentation

  spec.files         = Dir["bin/*", "lib/**/*", "README.md", "LICENSE.txt"]
  spec.bindir        = "bin"
  spec.executables   = ["hyraft-server", "hyr-serve", 'hyr']
  spec.require_paths = ["lib"]

  # Runtime dependencies
  spec.add_dependency "rack", "~> 3.2"

  # Development dependencies - ADD YARD HERE
  spec.add_development_dependency "rake", "~> 13.3"
  spec.add_development_dependency "minitest", "~> 5.26"
  spec.add_development_dependency "yard", "~> 0.9.34"  # ← ADD THIS
  spec.add_development_dependency "redcarpet", "~> 3.6"  # Optional: for markdown support
end