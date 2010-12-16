# -*- coding: utf-8 -*-

require 'sinatra/base'

module Lookout module Rack end end

class Lookout::Rack::FakeApp < Sinatra::Base
  get '/' do
    'GET: %p' % params
  end

  post '/' do
    'POST: %p' % params
  end

  get '/redirected' do
    redirect '/target'
  end

  get '/target' do
    'you have been successfully redirected to target'
  end
end
