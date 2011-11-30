Gem::Specification.new do |s|

  s.name        = 'ghaki-env'
  s.summary     = 'Run mode discovery helpers'
  s.description = 'Collection of application helpers for dealing with the run time environment.'

  s.version = IO.read(File.expand_path('VERSION')).chomp

  s.authors  = ['Gerald Kalafut']
  s.email    = 'gerald@kalafut.org'
  s.homepage = 'http://github.com/ghaki'

  # rubygem setup
  s.platform                  = Gem::Platform::RUBY
  s.required_rubygems_version = '>= 1.3.6'
  s.rubyforge_project         = s.name

  # prod dependencies
  s.add_dependency 'ghaki-app', '>= 1.1.2'

  # devel dependencies
  s.add_development_dependency 'rspec', '>= 2.4.0'
  s.add_development_dependency 'mocha', '>= 0.9.12'
  s.add_development_dependency 'rdoc',  '>= 3.9.4'

  # rdoc setup
  s.has_rdoc = true
  s.extra_rdoc_files = ['README']

  # manifest
  s.files = Dir['{lib,bin}/**/*'] + %w{ README LICENSE }
  s.test_files = Dir['spec/**/*_spec.rb','*spec/**/*_helper.rb']

  s.require_path = 'lib'
end
