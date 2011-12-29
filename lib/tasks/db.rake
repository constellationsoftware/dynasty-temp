#
# For reference, the ActiveRecord db task source can be found here:
# https://github.com/rails/rails/blob/master/activerecord/lib/active_record/railties/databases.rake
#

db_namespace = namespace :db do
  desc "Run :task against :database"
  task :with, [:database,:task] => [:environment] do |t, args|
    puts "Applying #{args.task} to #{args.database}"
    ENV['SCHEMA'] ||= "#{Rails.root}/db/schema_#{args.database}.rb"
    begin
      oldRailsEnv = Rails.env
      Rails.env = args.database
      ActiveRecord::Base.establish_connection(args.database)
      ActiveRecord::Migrator.migrations_paths = ["db/migrate_#{args.database}"]

      case args.task
      when 'db:seed'
        db_namespace['abort_if_pending_migrations'].invoke
        seed_file = File.join(Rails.root, 'db', "seeds_#{args.database}.rb")
        load(seed_file) if File.exist?(seed_file)
      when 'db:migrate'
        ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
        ActiveRecord::Migrator.migrate("#{Rails.root}/db/migrate_#{Rails.env}", ENV["VERSION"] ? ENV["VERSION"].to_i : nil)
        Rake::Task["db:with[#{Rails.env},'db:schema:dump']"].invoke if ActiveRecord::Base.schema_format == :ruby
      else
        Rake::Task[args.task].invoke
      end
    ensure
      Rails.env = oldRailsEnv
    end
  end
end
