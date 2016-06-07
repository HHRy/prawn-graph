# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'prawn/graph/version'

Gem::Specification.new do |spec|
  spec.name          = "prawn-graph"
  spec.version       = Prawn::Graph::VERSION
  spec.authors       = [
                          "Ryan Stenhouse",
                          "株式会社アルム (Allm Inc)", 
                       ]
  spec.email         = [
                          "ryan@ryanstenhouse.jp",
                          "r.stenhouse@allm.net",
                       ]

  spec.summary       = %q{Easily add graphs to Prawn PDF documents}
  spec.description   = %q{Prawn::Graph adds straightforward native graph drawing to Prawn without the need to depend on anything else. All generated graphs are pure PDF Vector Images. It results in smaller document sizes and less complication.}
  spec.homepage      = "https://ryanstenhouse.jp"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_runtime_dependency "prawn", ">= 0.11.1", "< 3"
end
