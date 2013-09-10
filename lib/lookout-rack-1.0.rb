# -*- coding: utf-8 -*-

# Namespace for [Lookout](http://disu.se/software/lookout-3.0/).  The bulk of the
# library is in {Lookout::Rack::Session}.
module Lookout end

# [Rack](http://rack.rubyforge.org/) interface for
# [Lookout](http://disu.se/software/lookout-3.0/).
module Lookout::Rack
  # The default host/URI to use for {Session#dispatch requests} and cookies.
  DefaultHost = 'example.org'

  # Base class for errors raised from Lookout::Rack.
  Error = Class.new(StandardError)

  # Error raised when a redirect is tried when none has been specified.
  RedirectError = Class.new(Error)

  # Error raised when a request hasn’t been made yet.
  RequestError = Class.new(Error)

  # Error raised when a response hasn’t been received yet.
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
