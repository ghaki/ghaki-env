require 'rubygems'
require 'rake'
require 'rake/gempackagetask'
require 'rake/rdoctask'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.rspec_opts = %w[--color]
  t.verbose = true
end

Rake::RDocTask.new('rdoc') do |t|
  t.rdoc_files.include( 'README', 'lib/**/*.rb')
  t.main = 'README'
  t.title = 'Ghaki Env API Documention'
end

Rake::GemPackageTask.new( Gem::Specification.load('Gemspec') ) do |pkg|
  pkg.need_zip = true
  pkg.need_tar = true
end
