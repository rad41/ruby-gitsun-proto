require 'net/http'

Net::HTTP.version_1_2

#addr = 'http://localhost:4567/'
addr = 'http://sin-hello-world.heroku.com/'
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
##  your.proxy.addr:8080 �ɑ΂��Ďw�肳�ꂽ���[�U���ƃp�X���[�h�Őڑ����܂��B
##  �����āAyour.proxy.addr:8080 ���o�R���āAwww.example.com �ɐڑ����܂��B
#}

Net::HTTP.start(uri.host,4567) {|http|
		p http
		response = http.get('/')
		
		p response.body
		
#  your.proxy.addr:8080 �ɑ΂��Ďw�肳�ꂽ���[�U���ƃp�X���[�h�Őڑ����܂��B
#  �����āAyour.proxy.addr:8080 ���o�R���āAwww.example.com �ɐڑ����܂��B
}

