require 'sinatra'
require 'json'

get '/' do
  "Hello Capital One!"
end

get '/app.json' do
  JSON.generate({key: '124', name: 'Justin'})
end

post 'new' do
  JSON.parse(params)
end
