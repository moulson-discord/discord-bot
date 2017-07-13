class Bot < ApplicationRecord
	require 'discordrb'
	require 'configatron'
	require 'json'
	require 'net/http'
	require 'open-uri'
	require 'base64'
	require_relative 'config.rb'
	def self.youtube_dl(url, title)
		#options = {output: "#{Rails.root}/app/assets/music/#{title}", extract_audio: true}
		#YoutubeDL.download url, options
		
		video = YoutubeDL::Video.new(url)
		video.options.configure do |c|
		  c.output = "#{Rails.root}/app/assets/music/#{title.gsub(' ','_').gsub('.', '').downcase}.mp3"
		  c.extract_audio = true
		  c.audio_format = 'mp3'
		end

		video.download
	end

	def self.start
		bot = Discordrb::Commands::CommandBot.new token: configatron.token, client_id: 217444617899999232, prefix: '!'
		bot.command :🤣 do |event|
			event.respond '🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣🤣'
		end

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
			break unless event.user.id == 137281612818677761 #Only I can do this

			channel = event.user.voice_channel

			next "no channel" unless channel

			bot.voice_connect(channel)
			"Connected to voice channel: #{channel.name}"
		end

		bot.command(:play) do |event, url|

			
			my_uri = URI.parse("https://www.youtube.com/oembed?url=#{url}&format=json")
			json = JSON.parse(Net::HTTP.get(my_uri))
			song_name = json["title"]
			thumb64 = Base64.encode64(open(json["thumbnail_url"], "rb").read)

			if Song.where(song_url: url).exists?
				finish_message = "Song already exists, playing #{song_name}"
				song_file = ("#{Rails.root}/app/assets/music/#{song_name.gsub('.','').gsub(' ', '_').downcase}.mp3")
			else
				youtube_dl(url, song_name)
				song_params = {song_url: url, platform: "youtube", title: song_name, song_file_file_name: "#{Rails.root}/app/assets/music/#{song_name.gsub('.','').gsub(' ', '_').downcase}.mp3", thumb64: thumb64}
				song = Song.create(song_params)
				finish_message = "downloading and playing #{song_name}"
				song_file = song.song_file_file_name
			end

			bot.send_message(event.channel.id, finish_message)
			voice_bot = event.voice
			voice_bot.play_file(song_file)
		end
		bot.run
	end
end
