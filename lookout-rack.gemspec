# -*- coding: utf-8 -*-

$:.unshift File.expand_path('../lib', __FILE__)
require 'lookout/rack/version'

Gem::Specification.new do |s|
  s.name = 'lookout-rack'
  s.version = Lookout::Rack::Version

  s.author = 'Nikolai Weibull'
  s.email = 'now@bitwi.se'
  s.homepage = 'http://github.com/now/lookout-rack'

  s.description = IO.read(File.expand_path('../README', __FILE__))
  s.summary = s.description[/^[[:alpha:]]+.*?\./]

  s.files = Dir['{lib,test}/**/*.rb'] + %w[README Rakefile]

  s.add_runtime_dependency 'lookout', '~> 2.0'
  s.add_runtime_dependency 'rack', '~> 1.0'

  s.add_development_dependency 'sinatra', '~> 1.0'
  s.add_development_dependency 'yard', '~> 0.6.0'
end
