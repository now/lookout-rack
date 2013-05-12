# -*- coding: utf-8 -*-

module Lookout::Rack::Methods
  private

  def session
    @app ||= begin
               Rack::Builder.parse_file('fixtures/config.ru')
             rescue Errno::ENOENT
               Rack::Builder.parse_file('config.ru')
             end[0]
    Lookout::Rack::Session.new(@app)
  end
end
