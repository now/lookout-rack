# -*- coding: utf-8 -*-

require File.expand_path('../app', __FILE__)
use Rack::Lint
run Lookout::Rack::TestApp
