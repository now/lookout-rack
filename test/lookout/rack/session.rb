# -*- coding: utf-8 -*-

Expectations do
  expect 'GET' do
    session.get('/').request.env['REQUEST_METHOD']
  end

  expect 200 do
    session.get('/').response.status
  end

  expect session.to.have.response.redirect? do |s|
    s.get('/redirected')
  end

  expect session.not.to.have.response.redirect? do |s|
    s.get('/redirected').follow_redirect!
  end

  expect 'you have been successfully redirected to target' do
    session.get('/redirected').follow_redirect!.response.body
  end

  expect({}) do
    session.get('/redirected').follow_redirect!.request.GET
  end

  expect Lookout::Rack::ResponseError do
    session.follow_redirect!
  end

  expect Lookout::Rack::RedirectError do
    session.get('/').follow_redirect!
  end
end
