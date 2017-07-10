class Bot < ApplicationRecord
	require 'discordrb'
	require 'configatron'
	require 'json'
	require 'net/http'
	require_relative 'config.rb'

	def self.start
		bot = Discordrb::Commands::CommandBot.new token: configatron.token, client_id: 217444617899999232, prefix: '!'

		bot.command :d20 do |event|
			r = Random.new
			bot.send_message(event.channel.id, r.rand(1...20).to_s)
		end
		bot.command(:ping) do |event|
	  		event.respond 'Pong!'
		end
		bot.command(:stop, help_available: false) do |event|
			break unless event.user.id == 137281612818677761 #Only I can do this

			bot.send_message(event.channel.id, 'Bot is shutting down')
			exit
		end
		bot.command(:summon) do |event|
			# The `voice_channel` method returns the voice channel the user is currently in, or `nil` if the user is not in a
			# voice channel.
			channel = event.user.voice_channel

			next "no channel" unless channel

			bot.voice_connect(channel)
			"Connected to voice channel: #{channel.name}"
		end

		#bot.command(:songinfo) do |event, url|
		#	uri = URI.parse()
		#	response = Net::HTTP.get(uri)
		#	json = JSON.parse(response)
		#	"Song Name: #{json["title"]}"
		#end

		# A simple command that plays back an mp3 file.
		bot.command(:play) do |event, url|
			my_uri = URI.parse("https://www.youtube.com/oembed?url=#{url}&format=json")
			json = JSON.parse(Net::HTTP.get(my_uri))
			song_name = json["title"]
			song_params = {song_url: song_name, platform: "youtube"}
			Song.create(song_params)
			#Check all current songs for the URL
			#if it exists, add it to the queue
			#otherwise, download first, create song object then add to the queue.

			#Create song object with url
			#voice_bot = event.voice
			#voice_bot.play_file("http://freesound.org/data/previews/397/397235_1648170-lq.mp3")
		end
		bot.run
	end
end
