# -*- coding: utf-8 -*-

module Lookout end

module Lookout::Rack
  DefaultHost = 'example.org'

  Error = Class.new(StandardError)
  RedirectError = Class.new(Error)
  RequestError = Class.new(Error)
  ResponseError = Class.new(Error)

  load File.expand_path('../lookout-rack-1.0/version.rb', __FILE__)
  Version.load
end

class Lookout::Expectations::Context
  include Lookout::Rack::Methods
end

class Lookout::Expect::Object::Context
  include Lookout::Rack::Methods
end
