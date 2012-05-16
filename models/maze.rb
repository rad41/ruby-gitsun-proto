# -*- encoding: utf-8 -*-
#!/usr/bin/ruby

require 'mongoid'

class Maze
	include Mongoid::Document
	field :name
	embedded_in :player_info, :inverse_of=>:maze
	embeds_many :cells
end

class MazeCell
	include Mongoid::Document
	field :cellType, :type => Integer, :default => 1
	embedded_in :maze, :inverse_of=>:cells
end
