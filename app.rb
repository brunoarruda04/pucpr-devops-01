require 'sinatra'

get '/' do
  "Hello, Docker com Ruby!"
end

tasks = []

get '/tasks' do
  tasks.to_json
end

set :bind, '0.0.0.0'
set :port, 4567