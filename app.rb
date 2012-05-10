require 'rubygems'
require 'sinatra'
require 'sinatra/base'
require 'sinatra/reloader' if development?
require 'mongoid'
require 'json'

#mongodb://heroku:35f5c5b169383ec52b98b726e6b228dd@staff.mongohq.com:10085/app4332041

Mongoid.configure do |config|
	#config.master = Mongo::Connection.from_uri('mongodb://heroku:35f5c5b169383ec52b98b726e6b228dd@staff.mongohq.com:10085/app4332041').db('app4332041')
	config.master = Mongo::Connection.new.db('test')
end

class Homu
  include Mongoid::Document
  field :name
end

get '/' do
 'Hello World!!'
end

#post '/user' do
#
#	homu = Homu.new(:name => "gitsun")
#
#end
#
get '/user' do
	homu = Homu.new(:name => "gitsun")
	#user = Homu.find(:name => "gitsun" )
	
#	if user
  content_type :json
  { :key1 => homu.name }.to_json
		
	#else
	#	'nothing'
	#end
end

