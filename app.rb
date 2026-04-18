require 'sinatra'
require 'json'

# armazenamento em memória
set :tasks, []

before do
  content_type :json
end

get '/' do
  { message: "API Ruby funcionando!" }.to_json
end

# listar tarefas
get '/tasks' do
  settings.tasks.to_json
end

# criar tarefa
post '/tasks' do
  data = JSON.parse(request.body.read)

  task = {
    id: (settings.tasks.size + 1).to_s,
    title: data["title"]
  }

  settings.tasks << task
  task.to_json
end

# deletar tarefa
delete '/tasks/:id' do
  settings.tasks.delete_if { |task| task[:id] == params[:id] }
  status 204
end

set :bind, '0.0.0.0'
set :port, 4567