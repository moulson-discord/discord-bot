class Bot < ApplicationRecord
	require 'discordrb'
	require 'configatron'
	require_relative 'config.rb'

	def self.start
		bot = Discordrb::Commands::CommandBot.new token: configatron.token, client_id: 217444617899999232, prefix: '!'

		bot.message(with_text: 'Ping!') do |event|
	  		event.respond 'Pong!'
		end
		bot.run
	end
end
