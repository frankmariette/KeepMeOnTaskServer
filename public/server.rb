require 'bundler/setup'
require 'sinatra'
require 'mongo_mapper'

class Log
  include MongoMapper::Document

  key :userid, String
  key :site_visited, String
  key :redirected_to, String
  timestamps!

end

configure do
  MongoMapper.database = 'keepmeontask'
end

get '/' do
  "Hello there from Sinatra"
end

get '/logs' do
  content_type = "text/plain"
  logs = Log.all(:order => :userid.asc)
  logs.each do |l|
    puts l.userid
  end
end

post '/logs' do
  body = request.body.rewind
  data = JSON.parse request.body.read

  log = Log.new(
    userid: data['userid'],
    site_visited: data['site_visited'],
    redirected_to: data['redirected_to']
  );
  log.save(:safe => true)
end
