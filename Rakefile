# -*- coding: utf-8 -*-

require 'lookout/rake/tasks'
require 'yard'

Lookout::Rake::Tasks::Test.new do |t|
  t.requires = %w[lookout/rack]
end
Lookout::Rake::Tasks::Gem.new
YARD::Rake::YardocTask.new
