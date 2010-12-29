# -*- coding: utf-8 -*-

require 'lookout'
require 'rack'
require 'time'
require 'uri'

module Lookout::Rack
  DefaultHost = 'example.org'

  Error = Class.new(StandardError)
  RedirectError = Class.new(Error)
  RequestError = Class.new(Error)
  ResponseError = Class.new(Error)

  autoload :Cookie, 'lookout/rack/cookie'
  autoload :Cookies, 'lookout/rack/cookies'
  autoload :Methods, 'lookout/rack/methods'
  autoload :Request, 'lookout/rack/request'
  autoload :Session, 'lookout/rack/session'
end

class Lookout::Expectations
  include Lookout::Rack::Methods
end

module Lookout::Expectation
  include Lookout::Rack::Methods
end
