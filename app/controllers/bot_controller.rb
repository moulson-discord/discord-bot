class BotController < ApplicationController
	def start
		system "rake start_bot"
		flash[:notice] = "Bot is running"
	end

	def stop
		flash[:notice] = 'Stopping bot'
		lines = (`ps aux | grep 'rake start_bot'`).split(/\n/)
		debugger
	end
end
