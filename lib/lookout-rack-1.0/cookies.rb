# -*- coding: utf-8 -*-

class Lookout::Rack::Cookies
  def initialize(default_host = Lookout::Rack::DefaultHost)
    @default_host = default_host
    @cookies = {}
  end

  def merge!(headers, uri = nil)
    headers.split("\n").reject{ |c| c.empty? }.each do |header|
      cookie = Lookout::Rack::Cookie.new(header, uri, @default_host)
      @cookies[cookie] = cookie if cookie.valid? uri
    end
    self
  end

  def for(uri)
    @cookies.values.select{ |c| c.matches? uri }.sort.
      reduce({}){ |h, c| h[c.name] = c; h }.values.join(';')
  end
end
