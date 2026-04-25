# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'

require_relative '../app'
require 'rack/test'

RSpec.describe 'API Tasks' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  before do
    app.settings.tasks.clear
  end

  it 'retorna mensagem na raiz' do
    get '/'
    expect(last_response).to be_ok
  end

  it 'lista tarefas (inicialmente vazio)' do
    get '/tasks'
    expect(last_response).to be_ok
    expect(JSON.parse(last_response.body)).to eq([])
  end

  it 'cria uma tarefa' do
    post '/tasks', { title: 'Test task' }.to_json, { 'CONTENT_TYPE' => 'application/json' }

    expect(last_response).to be_ok
    body = JSON.parse(last_response.body)
    expect(body['title']).to eq('Test task')
  end

  it 'lista tarefas após criação' do
    post '/tasks', { title: 'Task 2' }.to_json, { 'CONTENT_TYPE' => 'application/json' }
    get '/tasks'

    tasks = JSON.parse(last_response.body)
    expect(tasks.length).to be >= 1
  end

  it 'deleta uma tarefa' do
    post '/tasks', { title: 'To delete' }.to_json, { 'CONTENT_TYPE' => 'application/json' }
    delete '/tasks/1'

    expect(last_response.status).to eq(204)
  end
end
