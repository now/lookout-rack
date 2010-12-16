# -*- coding: utf-8 -*-

require 'lookout'
require 'rack'
require 'uri'

module Lookout::Rack
  Error = Class.new(StandardError)
  RedirectError = Class.new(Error)
  RequestError = Class.new(Error)
  ResponseError = Class.new(Error)

  autoload :Methods, 'lookout/rack/methods'
  autoload :Request, 'lookout/rack/request'
  autoload :Session, 'lookout/rack/session'
end

module Lookout::Expectation
  include Lookout::Rack::Methods
end

class Lookout::Suite
  include Lookout::Rack::Methods
end
