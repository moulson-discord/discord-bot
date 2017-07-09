class Bot < ApplicationRecord
	require 'discordrb'
	require 'configatron'
	require_relative 'config.rb'

	def self.start
		bot = Discordrb::Commands::CommandBot.new token: configatron.token, client_id: 217444617899999232, prefix: '!'

		bot.command :d20 do |event|
			rand(1,20).to_s
		end
		bot.message(with_text: 'Ping!') do |event|
	  		event.respond 'Pong!'
		end
		bot.command(:exit, help_available: false) do |event|
		  break unless event.user.id == 137281612818677761 #Only I can do this

		  bot.send_message(event.channel.id, 'Bot is shutting down')
		  exit
		end
		bot.run
	end
end
