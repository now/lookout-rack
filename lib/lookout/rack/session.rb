# -*- coding: utf-8 -*-

class Lookout::Rack::Session
  def initialize(app, options = {})
    @app = app
    @request = nil
    @response = nil
  end

  def get(uri, options = {})
    dispatch('GET', uri, options)
  end

  def post(uri, options = {})
    dispatch('POST', uri, options)
  end

  def put(uri, options = {})
    dispatch('PUT', uri, options)
  end

  def delete(uri, options = {})
    dispatch('DELETE', uri, options)
  end

  def dispatch(method, uri = '', options = {})
    env = Rack::MockRequest.env_for(uri, options.merge(:method => method))
    @request = Rack::Request.new(env)
    errors = env['rack.errors']
    @response = Rack::MockResponse.
      new(*((options[:lint] ? Rack::Lint.new(@app) : @app).call(env) + [errors]))
    self
  end

  def request
    @request or raise Lookout::Rack::RequestError, 'no request has been sent yet'
  end

  def response
    @response or raise Lookout::Rack::ResponseError, 'no response has been received yet'
  end

  def follow_redirect!
    response.redirect? or
      raise Lookout::Rack::RedirectError, 'most recent response was not a redirect' 
    get(response['Location'])
  end
end
