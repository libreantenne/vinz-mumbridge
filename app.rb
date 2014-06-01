# coding: UTF-8

require 'mumble-ruby'
require 'socket'
require 'htmlentities'
require 'sanitize'
require './function.inc.rb'

coder = HTMLEntities.new

# [CONFIG IRC]
@server = 'irc.inframonde.org'
@port = 6667
@channel = '#antenne'
@nick = 'M'
@verbose = false
# [/CONFIG]

# [CONFIG MuMBLE]
@mserver = 'libreantenne.org'
@mport = 64738
@mnick = '|'
# [/CONFIG]

$cli = Mumble::Client.new(@mserver, @mport, @mnick)

$cli.on_text_message do |msg| 
	case msg.message.chomp
		when /^#/
			puts "Command, not forwarded to IRC."
		when //
			say("#{$cli.users[msg.actor].name}> #{coder.decode(Sanitize.clean(msg.message))}", @channel)
			puts "#{$cli.users[msg.actor].name}@M> #{msg.message}"
		when "disconnect"
			$cli.disconnect
		else
			puts msg.message
	end
end

$irc = TCPSocket.new(@server, @port)

["NICK #{@nick}", "USER #{@nick} 0 * :Suppositoire"].each { |command|
  $irc.puts(command)
}
sleep 10
$cli.connect
sleep 1
join @channel

while line = $irc.gets.strip
	if line =~ /PRIVMSG ([^ :]+) +:(.+)/
		m, sender, target, message = *line.match(/:([^!]*)![^ ].* +PRIVMSG ([^ :]+) +:(.+)/)
		message = message.gsub(/((http:\/\/|https:\/\/)?(www.)?(([a-zA-Z0-9\-]){2,}\.){1,4}([a-zA-Z]){2,6}(\/([a-zA-Z\-_\/\.0-9#:?=&;,\+%]*)?)?)/, '<a href="\1">\1</a>')
		$cli.text_channel("Root", "<span style=\"color: #663399;\">#{sender}</span> : #{message.force_encoding("UTF-8")}")
		puts "#{sender}@IRC> #{message}"
	end

	if line =~ /^:(\w+)!.+JOIN.+$/
		$cli.text_channel("Root", "<i>*#{$1} joined*</i>")
	end

	if line =~ /PING :(.+)$/
		puts("--> Server PING [#{$1}]")
		sendRaw("PONG :#{$1}")
	end

	if line =~ /(.*)/ && @verbose
		puts($1)
	end
end
