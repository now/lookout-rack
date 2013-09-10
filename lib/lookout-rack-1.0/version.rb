# -*- coding: utf-8 -*-

require 'inventory-1.0'

module Lookout::Rack
  Version = Inventory.new(1, 0, 1){
    authors{
      author 'Nikolai Weibull', 'now@disu.se'
    }

    homepage 'http://disu.se/software/lookout-rack-1.0/'

    licenses{
      license 'LGPLv3+',
              'GNU Lesser General Public License, version 3 or later',
              'http://www.gnu.org/licenses/'
    }

    def dependencies
      super + Inventory::Dependencies.new{
        development 'inventory-rake', 1, 6, 0
        development 'inventory-rake-tasks-yard', 1, 4, 0
        development 'lookout-rake', 3, 1, 0
        development 'sinatra', 1, 0, 0
        development 'yard', 0, 8, 0
        development 'yard-heuristics', 1, 2, 0
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
