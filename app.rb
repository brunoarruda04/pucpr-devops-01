# frozen_string_literal: true

require 'sinatra'
require 'json'

helpers do
  def tasks
    settings.tasks ||= []
  end
end

before do
  content_type :json
end

get '/' do
  { message: 'API Ruby funcionando!' }.to_json
end

get '/tasks' do
  tasks.to_json
end

post '/tasks' do
  data = JSON.parse(request.body.read)

  task = {
    id: (tasks.size + 1).to_s,
    title: data['title']
  }

  tasks << task
  task.to_json
end

delete '/tasks/:id' do
  tasks.delete_if { |task| task[:id] == params[:id] }
  status 204
end

set :bind, '0.0.0.0'
set :port, 4567
