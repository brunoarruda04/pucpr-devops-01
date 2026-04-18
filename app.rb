require 'sinatra'

get '/' do
  "Hello, Docker com Ruby!"
end

tasks = []

get '/tasks' do
  tasks.to_json
end

post '/tasks' do
  task = JSON.parse(request.body.read)
  tasks << task
  task.to_json
end

delete '/tasks/:id' do
  tasks.delete_if { |task| task['id'] == params[:id] }
  status 204
end

set :bind, '0.0.0.0'
set :port, 4567