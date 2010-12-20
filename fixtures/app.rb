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

  get '/cookies/show' do
    request.cookies.inspect
  end

  get '/cookies/set' do
    response.set_cookie 'value',
      :value => params['value'],
      :path => '/cookies',
      :expires => Time.now + 60

    'cookie has been set'
  end

  get '/cookies/expired' do
    response.set_cookie 'value',
      :value => params['value'],
      :path => '/cookies',
      :expires => Time.now - 60

    'expired cookie have been set'
  end

  get '/no-cookies/show' do
    request.cookies.inspect
  end

  get '/cookies/delete' do
    response.delete_cookie 'value'
  end

  get '/COOKIES/show' do
    request.cookies.inspect
  end

  get '/cookies/set-uppercase' do
    response.set_cookie 'VALUE',
      :value => params['value'],
      :path => '/cookies',
      :expires => Time.now + 60

    'cookie has been set'
  end

  get '/cookies/set-simple' do
    response.set_cookie 'simple', params['value']

    'cookie has been set'
  end

  get '/cookies/set-secure' do
    response.set_cookie 'value',
      :value => params['value'],
      :secure => true

    'cookie has been set'
  end

  get '/cookies/subdomain' do
    response.set_cookie 'count',
      :value => ((request.cookies['count'].to_i or 0) + 1).to_s,
      :domain => '.example.com'

    'cookie has been set'
  end

  get '/cookies/set-multiple' do
    response.set_cookie 'value', :value => '1'
    response.set_cookie 'other', :value => '2'

    'cookies have been set'
  end

  get '/cookies/count' do
    response.set_cookie 'count',
      :value => ((request.cookies['count'].to_i or 0) + 1).to_s

    'cookie has been set'
  end
end
