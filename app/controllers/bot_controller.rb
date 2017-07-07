class BotController < ApplicationController
	def start
		Bot.start
	end
	def stop
		Bot.stop
	end
end
