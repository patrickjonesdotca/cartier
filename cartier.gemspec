# -*- encoding: utf-8 -*-
require File.expand_path('../lib/cartier/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Patrick Jones"]
  gem.email         = ["patrick@patrickjones.ca"]
  gem.description   = %q{Cartier is a gem to be used to simply dealing with GPS data calculations such as distance, location, and bearing.}
  gem.summary       = %q{Cartier is a gem to be used to simply dealing with GPS data calculations such as distance, location, and bearing.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "cartier"
  gem.require_paths = ["lib"]
  gem.version       = Cartier::VERSION
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "factory_girl"
end
