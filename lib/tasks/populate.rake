# a simple/configurable rake task that generates some random fake data for the app (using faker) at various sizes
require 'fabrication'
require 'forgery'

class Fakeout
    # START Customizing

    # these are the model names we're going to fake
    MODELS = %w( Account Clock Pick Draft Events::Base Game League PlayerTeamPoint PlayerTeam Favorite Team Trade User UserAddress Waiver )

    attr_accessor :size, :season

    def initialize(size, fabricator)
        @size = size
        @season = Season.current
        @fabricator = ("league_#{fabricator}").to_sym
    end

    def fakeout
        puts "Generating #{@size} #{@size === 1 ? 'league' : 'leagues'} using fabricator: #{@fabricator.to_s}"
        Fakeout.disable_mailers

=begin
        MODELS.each do |model|
            unless respond_to? "build_#{model.downcase}"
                puts "  * #{model.pluralize}: WARNING: I couldn't find a build_#{model.downcase} method"
                next
            end
            1.upto(send(size)) do
                attributes = send("build_#{model.downcase}")
                model.constantize.create!(attributes) if attributes && !attributes.empty?
            end
            puts "  * #{model.pluralize}: #{model.constantize.count(:all)}"
        end
=end

        # create a single clock
        Clock.create! :time => @season.start_date.at_midnight
        # create leagues
        @size.times { Fabricate @fabricator }
        League.all.each do |league|
            GameScheduler.instance.schedule(league.teams) if league.teams.size === Settings.league.capacity
        end

        names = %W( nick ben andrew paul kyle )
        League.first.users.each_with_index do |user, i|
            unless names[i].nil?
                user.email = "#{names[i]}@dynastyowner.com"
                user.save!
            end
        end

        post_fake
        puts "Done!"
    end

    # called after faking out, use this method for additional updates or additions
    def post_fake
    end

    def self.prompt
        puts "Really? This will clean all #{MODELS.map(&:pluralize).join(', ')} from your #{Rails.env} database y/n? "
        STDOUT.flush
        (STDIN.gets =~ /^y|^Y/) ? true : exit(0)
    end

    def self.clean(no_prompt = false)
        self.prompt unless no_prompt
        puts 'Cleaning all ...'
        Fakeout.disable_mailers
        MODELS.each do |model|
            model.constantize.delete_all
        end
        puts 'Flushing user privileges'
        ActiveRecord::Base.connection.execute("TRUNCATE users_roles")
        ActiveRecord::Base.connection.execute("TRUNCATE roles")
    end

    # by default, all mailings are disabled on faking out
    def self.disable_mailers
        ActionMailer::Base.perform_deliveries = false
    end
end


# the tasks, hook to class above - use like so;
# rake fakeout:clean
# rake fakeout:small[noprompt] - no confirm prompt asked, useful for heroku or non-interactive use
# rake fakeout:medium RAILS_ENV=bananas
#.. etc.

# TODO: add an option to clear everything and start from scratch with initial seed data?
namespace :db do
    desc "clean away all data"
    task :clean, [:fabricator, :no_prompt] => :environment do |t, args|
        no_prompt = args[:no_prompt] || false
        Fakeout.clean(no_prompt)
        # Rake::Task['db:seed'].invoke
    end

    namespace :populate do
        desc "fake out a tiny dataset"
        task :tiny, [:fabricator, :no_prompt] => :clean do |t, args|
            size = 1
            fabricator = args[:fabricator] || 'full'
            Fakeout.new(size, fabricator).fakeout
        end

        desc "fake out a small dataset"
        task :small, [:fabricator, :no_prompt] => :clean do |t, args|
            size = 20# + rand(50)
            fabricator = args[:fabricator] || 'full'
            Fakeout.new(size, fabricator).fakeout
        end

        desc "fake out a medium dataset"
        task :medium, [:fabricator, :no_prompt] => :clean do |t, args|
            size = 250 + rand(250)
            fabricator = args[:fabricator] || 'full'
            Fakeout.new(size, fabricator).fakeout
        end

        desc "fake out a large dataset"
        task :large, [:fabricator, :no_prompt] => :clean do |t, args|
            size = 1000 + rand(500)
            fabricator = args[:fabricator] || 'full'
            Fakeout.new(size, fabricator).fakeout
        end

        desc "fake out a huge dataset"
        task :large, [:fabricator, :no_prompt] => :clean do |t, args|
            size = 3000 + rand(1000)
            fabricator = args[:fabricator] || 'full'
            Fakeout.new(size, fabricator).fakeout
        end
    end
end
