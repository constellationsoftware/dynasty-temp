namespace :users do
    desc 'Creates UUIDs for existing teams'
    task :create_uuids => :environment do
        num_changed = 0
        Team.all.each do |team|
            if team.uuid.nil?
                uuid = UUIDTools::UUID.timestamp_create
                team.uuid = uuid.raw
                team.save()
                num_changed += 1
            end
        end
        puts 'Modified ' + num_changed.to_s + ' rows.'
    end
end
