# -*- coding: utf-8 -*-

require 'inventory-1.0'

module Lookout::Rack
  Version = Inventory.new(1, 0, 0){
    def dependencies
      super + Inventory::Dependencies.new{
        development 'inventory-rake', 1, 4, 0
        development 'inventory-rake-tasks-yard', 1, 3, 0
        development 'lookout-rake', 3, 0, 0
        development 'sinatra', 1, 0, 0
        development 'yard', 0, 8, 0
        development 'yard-heuristics', 1, 1, 0
        runtime 'lookout', 3, 0, 0
        runtime 'rack', 1, 0, 0, :feature => 'rack'
      }
    end

    def requires
      %w[time
         uri]
    end

    def package_libs
      %w[cookie.rb
         cookies.rb
         methods.rb
         session.rb]
    end

    def additional_files
      %w[fixtures/app.rb
         fixtures/config.ru]
    end
  }
end
