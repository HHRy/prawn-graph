require 'rubygems'
require 'rake'
require "rake/gempackagetask" 
require "rake/rdoctask"

PRAWN_GRAPH_VERSION = '0.0.4'

spec = Gem::Specification.new do |spec|
  spec.name = "prawn-graph"
  spec.version = PRAWN_GRAPH_VERSION
  spec.platform = Gem::Platform::RUBY
  spec.summary = "An extension to Prawn that provides the ability to draw basic graphs and charts natively in your PDFs."
  spec.files = Dir.glob("{examples,lib,spec,vendor,data}/**/**/*") +
                      ["Rakefile"]
  spec.require_path = "lib"
  
  spec.test_files = Dir[ "test/*_test.rb" ]
  spec.has_rdoc = true
  spec.extra_rdoc_files = %w{README.markdown}
  spec.rdoc_options << '--title' << 'Prawn Documentation' <<
                       '--main' << 'README' << '-q'
  spec.author = "Ryan Stenhouse"
  spec.email = " ryan@ryanstenhouse.eu"
  spec.rubyforge_project = "prawn"
  spec.add_dependency 'prawn'
  spec.homepage = "http://ryanstenhouse.eu"
  spec.description = <<END_DESC
  An extension to Prawn that provides the ability to draw basic graphs and charts natively in your PDFs.
END_DESC
end

desc "genrates documentation"
Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_files.include( "README.markdown",
                           "COPYING",
                           "LICENSE", 
                           "HACKING", "lib/" )
  rdoc.main     = "README.markdown"
  rdoc.rdoc_dir = "doc/html"
  rdoc.title    = "Prawn Documentation"
end     

 
Rake::GemPackageTask.new(spec) do |pkg|
  pkg.need_zip = true
  pkg.need_tar = true
end
 
