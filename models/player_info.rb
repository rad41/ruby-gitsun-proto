# -*- encoding: utf-8 -*-
#!/usr/bin/ruby

require 'mongoid'

class UserInfo
  include Mongoid::Document
  field :name
  embeds_one :maze
end

