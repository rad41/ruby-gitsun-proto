# -*- encoding: utf-8 -*-
#!/usr/bin/ruby

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
	config.raise_not_found_error=false
end

class MazeCell
	include Mongoid::Document
	field :cell_type, :type=>Integer, :default=>0
#	embedded_in :maze_info, :inverse_of => :maze_cells
	embedded_in :maze_info
end

class MazeInfo
	include Mongoid::Document
	field :name
	embeds_many :maze_cells
	embedded_in :user_info, :inverse_of => :maze_info
end

class UserInfo
  include Mongoid::Document
  field :name
  embeds_one :maze_info
end


get '/' do
 content_type :json
 { :msg=>'Hello World!!!', :now=>Time.now.to_s}.to_json
end

post '/user/create' do
	
	content_type :json
	
	user = UserInfo.find(:first, :conditions=>{ :name => params[:name] } )
	
	if user
	
		{ :name=>user.name, :is_new=>'false' }.to_json
	
	else
	
=begin
		maze =  MazeInfo.new(:name => 'maze' )
	
		user = UserInfo.new(:name => params[:name])
		
		maze.user_info = user
		user.save
		{ :name=>maze.name }.to_json
=end
		user = UserInfo.new(:name => params[:name])
		
		maze =  MazeInfo.new(:name => user.name + ' maze' )
		
		maze.maze_cells << MazeCell.new( :cell_type=>2)
		maze.maze_cells << MazeCell.new( :cell_type=>4)
		user.maze_info = maze
		user.save
		{ :name=>maze.name }.to_json
	end
end

get 'user/maze'do

	content_type :json
	
	user = UserInfo.find(:first, :conditions=>{ :name => params[:name] } )
	
	if user
		{ :name => user.maze_info.name }.to_json
	end
	
	{}.to_json
end




