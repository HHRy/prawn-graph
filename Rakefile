require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'yard'


YARD::Rake::YardocTask.new do |t|
  t.files   = ['lib/**/*.rb', '-', '*.md']
end

RSpec::Core::RakeTask.new(:spec)

task :default => :spec
