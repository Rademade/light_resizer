# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'light_resizer/version'

Gem::Specification.new do |spec|
  spec.name          = "light_resizer"
  spec.version       = LightResizer::VERSION
  spec.authors       = ["Denis Sergienko", "Vladislav Melanitskiy"]
  spec.email         = ["olol.toor@gmail.com", "co@rademade.com"]
  spec.summary       = %q{Tiny rack middleware for image resizing.}
  spec.description   = %q{}
  spec.homepage      = "http://github.com/Rademade/light_resizer"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "mini_magick", "~> 3.7.0"
  spec.add_dependency "rack", "~> 1.5.2"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "pry"
end
