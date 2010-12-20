# -*- coding: utf-8 -*-

class Lookout::Rack::Session
  def initialize(app, options = {})
    @app = app
    @request = nil
    @response = nil
    clear
  end

  def get(uri, params = {}, env = {})
    dispatch('GET', uri, params, env)
  end

  def post(uri, params = {}, env = {})
    dispatch('POST', uri, params, env)
  end

  def put(uri, params = {}, env = {})
    dispatch('PUT', uri, params, env)
  end

  def delete(uri, params = {}, env = {})
    dispatch('DELETE', uri, params, env)
  end

  def dispatch(method, uri = '', params = {}, env = {})
    uri = URI(uri)
    uri.host ||= Lookout::Rack::DefaultHost
    env = Rack::MockRequest.env_for(uri.to_s, env.merge(:method => method, :params => params))
    env['HTTP_COOKIE'] ||= @cookies.for(uri)
    @request = Rack::Request.new(env)
    errors = env['rack.errors']
    status, headers, body = *(env[:lint] ? Rack::Lint.new(@app) : @app).call(env)
    @response = Rack::MockResponse.new(status, headers, body, errors.flush)
    body.close if body.respond_to?(:close)
    @cookies.merge! @response.headers['Set-Cookie'], uri if @response.headers['Set-Cookie']
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

  def cookie(cookie, uri = nil)
    @cookies.merge! cookie
    self
  end

  def clear
    @cookies = Lookout::Rack::Cookies.new
    self
  end
end
