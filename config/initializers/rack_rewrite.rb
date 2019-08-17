if ENV['RACK_ENV'] == 'production'
  Nodopou::Application.config.middleware.insert_before(Rack::Runtime, Rack::Rewrite) do
    r301 %r{.*}, 'https://nodopou.herokuapp.com$&', :if => Proc.new { |rack_env|
      rack_env['SERVER_NAME'] == 'www.nodopou.com'
    }
  end
end