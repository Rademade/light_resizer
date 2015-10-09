# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'light_resizer/version'

Gem::Specification.new do |spec|
  spec.name          = 'light_resizer'
  spec.version       = LightResizer::VERSION
  spec.authors       = ['Denis Sergienko', 'Vladislav Melanitskiy']
  spec.email         = %w(olol.toor@gmail.com co@rademade.com)
  spec.summary       = %q{Tiny rack middleware for image resizing.}
  spec.description   = %q{}
  spec.homepage      = 'http://github.com/Rademade/light_resizer'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'rmagick'
  spec.add_dependency 'rack'
  spec.add_dependency 'image_optimizer', '~> 1.3.0'
  spec.add_dependency 'configurations', '~> 2.2.0'

end