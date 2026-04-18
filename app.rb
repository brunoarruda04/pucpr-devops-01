require 'sinatra'

get '/' do
  "Hello, Docker com Ruby!"
end

set :bind, '0.0.0.0'
set :port, 4567