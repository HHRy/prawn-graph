# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'prawn/graph/version'

Gem::Specification.new do |spec|
  spec.name          = "prawn-graph"
  spec.version       = Prawn::Graph::VERSION
  spec.authors       = ["Ryan Stenhouse"]
  spec.email         = ["ryan@ryanstenhouse.eu"]

  spec.summary       = %q{Simple graphs for PDF documents}
  spec.description   = %q{An extension to Prawn that provides the ability to draw basic graphs and charts natively in your PDFs.}
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
