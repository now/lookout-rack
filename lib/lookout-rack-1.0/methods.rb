# -*- coding: utf-8 -*-

# Methods added to [Lookout](http://disu.se/software/lookout)’s expectations
# and expect block context’s.
module Lookout::Rack::Methods
  private

  # @return [Session] A new session object that wraps the global Rack app found
  #   in the file “fixtures/config.ru” or “config.ru” in the top-level project
  #   directory.
  def session
    @app ||= begin
               Rack::Builder.parse_file('fixtures/config.ru')
             rescue Errno::ENOENT
               Rack::Builder.parse_file('config.ru')
             end[0]
    Lookout::Rack::Session.new(@app)
  end
end
