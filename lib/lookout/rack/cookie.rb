# -*- coding: utf-8 -*-

class Lookout::Rack::Cookie
  include Comparable

  def initialize(header, uri = nil, default_host = Lookout::Rack::DefaultHost)
    @default_host = default_host
    uri ||= default_uri

    @cookie, options = header.split(/[;,] */n, 2)

    @name, @value = Rack::Utils.parse_query(@cookie, ';').to_a.first

    @options = Hash[Rack::Utils.parse_query(options, ';').map{ |k, v| [k.downcase, v] }]
    @options['domain'] ||= uri.host || default_host
    @options['path'] ||= uri.path.sub(%r{/[^/]*\Z}, '')
  end

  def empty?
    @value.nil? or @value.empty?
  end

  def valid?(uri)
    uri ||= default_uri
    uri.host ||= @default_host

    real_domain = domain.start_with?('.') ? domain[1..-1] : domain
    secure? uri and
      uri.host.downcase.end_with? real_domain.downcase and
      uri.path.start_with? path
  end

  def matches?(uri)
    valid? uri and not expired?
  end

  def eql?(other)
    self.class === other and self == other
  end

  def <=>(other)
    [name.downcase, path, domain.reverse] <=>
      [other.name.downcase, other.path, other.domain.reverse]
  end

  def hash
    name.downcase.hash ^ path.hash ^ domain.hash
  end

  def to_s
    @cookie
  end

  attr_reader :name

protected

  def domain
    @options['domain']
  end

  def path
    @options['path'].strip
  end

private

  def default_uri
    URI('//%s/' % @default_host)
  end

  def secure?(uri)
    not @options.include? 'secure' or uri.scheme == 'https'
  end

  def expired?
    @options['expires'] and Time.parse(@options['expires']) < Time.now
  end
end
