desc "Start discord bot"
task :start_bot => :environment do
	Bot.start
end

desc "Stop discord bot"
task :start_bot => :environment do
	Bot.stop
end