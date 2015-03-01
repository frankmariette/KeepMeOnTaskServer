require 'sinatra'
require 'mongo_mapper'

class Log
  include MongoMapper::Document

  key :userid, String
  key :site_visited, String
  key :redirected_to, String
  key :timestamp, Time

end

get '/' do
  "Hello there from Sinatra"
end

post '/logs' do
  body = request.body.rewind
  data = JSON.parse request.body.read
  "Hello #{data}"
end
