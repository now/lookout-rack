# -*- coding: utf-8 -*-

# A [Rack](http://rack.rubyforge.org/) session for use with
# [Lookout](http://disu.se/software/lookout/).  Given a Rack “app”, it’ll allow
# you to make {#get}, {#post}, {#put}, and {#delete} requests (and actually
# {#dispatch} arbitrary requests, if you desire), check the sent {#request},
# check the received {#response}, follow {#redirect!}s, add {#cookie}s, and
# {#clear} cookies.
class Lookout::Rack::Session
  # Sets up a new session for APP.  You’ll most likely not call this yourself,
  # leaving it up to {Methods#session} to do so.
  #
  # @param [#call] app
  def initialize(app)
    @app = app
    @request = nil
    @response = nil
    clear
  end

  # Dispatches a GET request.
  # @param (see #dispatch)
  # @return (see #dispatch)
  def get(uri, params = {}, env = {})
    dispatch('GET', uri, params, env)
  end

  # Dispatches a POST request.
  # @param (see #dispatch)
  # @return (see #dispatch)
  def post(uri, params = {}, env = {})
    dispatch('POST', uri, params, env)
  end

  # Dispatches a PUT request.
  # @param (see #dispatch)
  # @return (see #dispatch)
  def put(uri, params = {}, env = {})
    dispatch('PUT', uri, params, env)
  end

  # Dispatches a DELETE request.
  # @param (see #dispatch)
  # @return (see #dispatch)
  def delete(uri, params = {}, env = {})
    dispatch('DELETE', uri, params, env)
  end

  # Dispatches a METHOD {#request} to URI with PARAMS in ENV and gets its
  # {#response}, storing any returned {#cookie}s.  For more information on ENV,
  # see
  # [Rack::MockRequest](http://rack.rubyforge.org/doc/classes/Rack/MockRequest.html).
  #
  # @param [String] method
  # @param [String] uri
  # @param [Hash] params
  # @param [Hash] env
  # @return [self]
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

  # @return [Rack::Request] The Rack request that was most recently sent during
  #   this session
  # @raise [RequestError] If no request has been sent yet
  def request
    @request or raise Lookout::Rack::RequestError, 'no request has been sent yet'
  end

  # @return [Rack::MockResponse] The Rack response that was most recently
  #   received during this session
  # @raise [RequestError] If no response has been received yet
  def response
    @response or raise Lookout::Rack::ResponseError, 'no response has been received yet'
  end

  # Redirects to the most recent response’s redirected location by performing a
  # {#get} request to the “Location” header of the response.
  #
  # @raise [RequestError] If no response has been received yet
  # @raise [RedirectError] If the last response wasn’t a redirect
  # @return [self]
  def redirect!
    response.redirect? or
      raise Lookout::Rack::RedirectError, 'most recent response was not a redirect'
    get(response['Location'])
  end

  # Sets COOKIE, being a newline-, comma-, and semicolon-separated list of
  # `KEY=VALUE` pairs, for URI, or the {Lookout::Rack::DefaultHost default
  # URI}, in the session.
  # @param [String] cookie
  # @param [String, nil] uri
  # @return [self]
  def cookie(cookie, uri = nil)
    @cookies.merge! cookie, uri
    self
  end

  # Clears all cookies from the session.
  # @return [self]
  def clear
    @cookies = Lookout::Rack::Cookies.new
    self
  end
end
