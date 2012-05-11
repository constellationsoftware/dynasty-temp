# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# If you want to create a data dump  from MySQL suitable for loading here, use this:
# mysqldump -u [user] -p -h localhost -tn --compact [source_db] > [filename].sql
#
=begin
base_dir = File.join Rails.root, 'db', 'data'
default_backup_name = 'dynasty'

# get database configuration
config   = Rails.configuration.database_configuration
host     = config[Rails.env]['host']
database = config[Rails.env]['database']
username = config[Rails.env]['username']
password = config[Rails.env]['password']
adapter  = config[Rails.env]['adapter']

# prompt for data file name
puts ''
puts "SQL dump filename for XMLTeam data (or enter for default)? #{base_dir}/[#{default_backup_name}].sql"
STDOUT.flush
input = STDIN.gets.chomp
filename = input === '' ? default_backup_name : input

# load the database in through the shell
load_cmd = case adapter
    when /^mysql/ then "mysql --user=#{username} --password=#{password} --host=#{host} --database=#{database} < #{base_dir}/#{filename}.sql"
    else raise "No support for #{adapter} database adapter"
end
puts 'Loading backup data. This may take a moment...'
begin
    system load_cmd
rescue => e
    puts "Loading backup data failed: #{e.message}"
    exit 0
end
=end
