# -*- coding: utf-8 -*-

Expectations do
  expect 'GET' do
    session.get('/').request.env['REQUEST_METHOD']
  end

  expect 200 do
    session.get('/').response.status
  end

  expect result.redirect? do
    session.get('/redirected').response
  end

  expect result.not.redirect? do
    session.get('/redirected').redirect!.response
  end

  expect 'you have been successfully redirected to target' do
    session.get('/redirected').redirect!.response.body
  end

  expect({}) do
    session.get('/redirected').redirect!.request.GET
  end

  expect Lookout::Rack::ResponseError do
    session.redirect!
  end

  expect Lookout::Rack::RedirectError do
    session.get('/').redirect!
  end

  expect({}) do
    session.get('/cookies/show').request.cookies
  end

  expect 'value' => '1' do
    session.get('/cookies/set', 'value' => '1').get('/cookies/show').request.cookies
  end

  expect 'value' => '1' do
    session.get('/cookies/set', 'value' => '1').get('/cookies/show').get('/cookies/show').request.cookies
  end

  expect({}) do
    session.get('/cookies/expired', 'value' => '1').get('/cookies/show').request.cookies
  end

  expect 'value' => '1' do
    session.get('http://example.org/cookies/set', 'value' => '1').get('http://example.org/cookies/show').request.cookies
  end

  expect({}) do
    session.get('http://example.org/cookies/set', 'value' => '1').get('http://example.net/cookies/show').request.cookies
  end

  expect({}) do
    session.get('/cookies/set', 'value' => '1').get('/no-cookies/show').request.cookies
  end

  expect({}) do
    session.get('/cookies/set', 'value' => '1').get('/cookies/delete').get('/cookies/show').request.cookies
  end

  expect 'value' => '1' do
    session.get('http://example.com/cookies/set', 'value' => '1').get('http://EXAMPLE.COM/cookies/show').request.cookies
  end

  expect({}) do
    session.get('/cookies/set', 'value' => '1').get('/COOKIES/show').request.cookies
  end

  expect 'value' => 'sub' do
    session.
      get('http://example.com/cookies/set', 'value' => 'domain').
      get('http://sub.example.com/cookies/set', 'value' => 'sub').
      get('http://sub.example.com/cookies/show').request.cookies
  end

  expect 'value' => 'domain' do
    session.
      get('http://example.com/cookies/set', 'value' => 'domain').
      get('http://sub.example.com/cookies/set', 'value' => 'sub').
      get('http://example.com/cookies/show').request.cookies
  end

  expect 'VALUE' => 'UPPERCASE' do
    session.
      get('/cookies/set', 'value' => 'lowercase').
      get('/cookies/set-uppercase', 'value' => 'UPPERCASE').
      get('/cookies/show').request.cookies
  end

  expect 'simple' => 'cookie' do
    session.
      get('http://example.com/cookies/set-simple', 'value' => 'cookie').
      get('http://example.com/cookies/show').request.cookies
  end

  expect({}) do
    session.
      get('http://example.com/cookies/set-simple', 'value' => 'cookie').
      get('http://example.com/cookies/show').
      get('http://example.net/cookies/show').request.cookies
  end

  expect({}) do
    session.get('/cookies/set-simple', 'value' => '1').get('/not-cookies/show').request.cookies
  end

  expect({}) do
    session.
      get('https://example.com/cookies/set-secure', 'value' => '1').
      get('http://example.com/cookies/show').request.cookies
  end

  expect 'value' => '1' do
    session.
      get('https://example.com/cookies/set-secure', 'value' => '1').
      get('https://example.com/cookies/show').request.cookies
  end

  expect 'value' => 'com' do
    session.
      get('http://example.com/cookies/set', 'value' => 'com').
      get('http://example.net/cookies/set', 'value' => 'net').
      get('http://example.com/cookies/show').request.cookies
  end

  expect 'count' => '2' do
    session.
      get('http://example.com/cookies/subdomain').
      get('http://example.com/cookies/subdomain').
      get('http://foo.example.com/cookies/subdomain').request.cookies
  end

  expect({}) do
    session.get('/cookies/set', 'value' => '1').clear.get('/cookies/show').request.cookies
  end

  expect 'value' => '1' do
    session.cookie('value=1').get('/cookies/show').request.cookies
  end

  expect 'value' => '1', 'other' => '2' do
    session.cookie("value=1\n\nother=2").get('/cookies/show').request.cookies
  end

  expect 'value' => '1', 'other' => '2' do
    session.get('/cookies/set-multiple').get('/cookies/show').request.cookies
  end

  expect 'first' => {'value' => '1'}, 'second' => {} do
    {
      'first' => session.get('/cookies/set', 'value' => '1').get('/cookies/show').request.cookies,
      'second' => session.get('/cookies/show').request.cookies
    }
  end

  expect 'count' => '1' do
    session.
      get('http://example.org/cookies/count').
      get('http://www.example.org/cookies/count').
      get('http://example.org/cookies/show').request.cookies
  end
end
