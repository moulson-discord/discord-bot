desc "Start discord bot"
task :start_bot => :environment do
	Bot.start
end
