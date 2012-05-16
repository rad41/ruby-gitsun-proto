# -*- encoding: utf-8 -*-
#!/usr/bin/ruby

require 'net/http'

Net::HTTP.version_1_2

addr = 'http://localhost:4567/'
#addr = 'http://sin-hello-world.heroku.com/'
uri = URI.parse(addr)
p uri.host

#proxy_host = 'your.proxy.host'
#proxy_port = 8080
#proxy_user = "username"
#proxy_pass = "password"
#
#proxy_class = Net::HTTP::Proxy(proxy_host)
#
#proxy_class.start(uri.host) {|http|
#		p host
##  your.proxy.addr:8080 に対して指定されたユーザ名とパスワードで接続します。
##  そして、your.proxy.addr:8080 を経由して、www.example.com に接続します。
#}

command = ARGV[0]
param = ARGV[1]

#if param
#	param = 'name=' + param
#end

p command
p param

def helloWorld( http )
	return http.get( '/' )
end

def createUser( http, user_name )
	if user_name
		query_hash = {"name" => user_name}
		query_string = (query_hash||{}).map{|k,v|
			URI.encode(k.to_s) + "=" + URI.encode(v.to_s)
			}.join("&")
			
		return http.post( '/user/create', query_string )
	end
	
	return nil
end


if command

	Net::HTTP.start(uri.host,4567) { |http|

		if http
			
			response = nil
			
			case command
			
			when 'test'
				response = helloWorld( http )
			
			when 'create_user'
				response = createUser( http, param )
				
			else
			
			end
=begin
			p http
			if req_type == 'get'
				p "get"
				response = http.get('/' + command )
			elseif req_type == 'post'
				p "post"
				if param
					response = http.post('/' + command, param )
				else
					response = http.post('/' + command )
				end
			end
=end
			
			if response && response.body
				p response.body
			end
		end
			
	}

end
	#  your.proxy.addr:8080 に対して指定されたユーザ名とパスワードで接続します。
	#  そして、your.proxy.addr:8080 を経由して、www.example.com に接続します。

