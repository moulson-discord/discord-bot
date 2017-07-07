class BotController < ApplicationController
	def start
		call_rake :start_bot
		flash[:notice] = "Bot is running"
	end
end
