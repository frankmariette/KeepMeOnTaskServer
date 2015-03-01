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

  content_type :json

  log = Log.new(
    userid: params[:userid],
    site_visited: params[:site_visited],
    redirected_to: params['redirected_to']
  );
  log.save(:safe => true)
end
