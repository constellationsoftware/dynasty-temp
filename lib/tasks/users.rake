namespace :users do
	desc 'Creates UUIDs for existing user_teams'
	task :create_uuids => :environment do
		num_changed = 0
		UserTeam.all.each do |team|
			if team.uuid.nil?
				uuid = UUIDTools::UUID.timestamp_create
 				team.uuid = uuid.raw
 				team.save()
 				num_changed += 1
			end
		end
		puts 'Modified ' + num_changed.to_s + ' rows.'
	end

  #TODO: Look at this. Getting noMethod errors.
	desc 'Sets user balances to 0 for users without a balance record'
	task :create_balance => :environment do
		num_changed = 0
		UserTeam.all.each do |team|
			if team.balance.nil?
				balance = UserTeamBalance.new
				team.balance = balance
				team.save
 				num_changed += 1
			end
		end
		puts 'Modified ' + num_changed.to_s + ' rows.'
	end
end
