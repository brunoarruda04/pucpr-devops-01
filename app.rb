# frozen_string_literal: true

require 'sinatra'
require 'json'
require 'dry/validation'

set :tasks, []

TaskSchema = Dry::Schema.Params do
  required(:title).filled(:string)
end

before do
  content_type :json
end

get '/' do
  { message: 'API Ruby funcionando!' }.to_json
end

get '/tasks' do
  settings.tasks.to_json
end

post '/tasks' do
  data = JSON.parse(request.body.read)
  result = TaskSchema.call(data)

  halt 400, { error: result.errors.to_h }.to_json unless result.success?

  task = {
    id: (settings.tasks.size + 1).to_s,
    title: data['title']
  }

  settings.tasks << task
  task.to_json
end

delete '/tasks/:id' do
  settings.tasks.delete_if { |task| task[:id] == params[:id] }
  status 204
end

set :bind, '0.0.0.0'
set :port, 4567
