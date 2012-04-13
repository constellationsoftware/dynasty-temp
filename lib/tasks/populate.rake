# a simple/configurable rake task that generates some random fake data for the app (using faker) at various sizes
require 'fabrication'
require 'forgery'

class Fakeout
    # START Customizing

    # these are the model names we're going to fake
    MODELS = %w( Account Clock Pick Draft Events::Base Game League PlayerTeam Favorite Team Trade User UserAddress )

    attr_accessor :size, :season

    def initialize(size, prompt = true)
        @size = size
        @season = Season.current
    end

    def fakeout
        puts "Generating #{@size} #{@size === 1 ? 'league' : 'leagues'}"
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
        @size.times { Fabricate :full_league }
        League.all.each do |league|
            GameScheduler.instance.schedule(league.teams) if league.teams.size === Settings.league.capacity
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

    def self.clean(prompt = true)
        self.prompt if prompt
        puts 'Cleaning all ...'
        Fakeout.disable_mailers
        MODELS.each do |model|
            model.constantize.delete_all
        end
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
    task :clean, [:no_prompt] => :environment do |t, args|
        #Fakeout.clean(args.no_prompt.nil?)
        Fakeout.clean(false)
        # Rake::Task['db:seed'].invoke
    end

    namespace :populate do
        desc "fake out a tiny dataset"
        task :tiny, [:no_prompt] => :clean do |t, args|
            size = 1
            Fakeout.new(size).fakeout
        end

        desc "fake out a small dataset"
        task :small, [:no_prompt] => :clean do |t, args|
            size = 20# + rand(50)
            Fakeout.new(size).fakeout
        end

        desc "fake out a medium dataset"
        task :medium, [:no_prompt] => :clean do |t, args|
            size = 250 + rand(250)
            Fakeout.new(size).fakeout
        end

        desc "fake out a large dataset"
        task :large, [:no_prompt] => :clean do |t, args|
            size = 1000 + rand(500)
            Fakeout.new(size).fakeout
        end

        desc "fake out a huge dataset"
        task :large, [:no_prompt] => :clean do |t, args|
            size = 3000 + rand(1000)
            Fakeout.new(size).fakeout
        end
    end
end
