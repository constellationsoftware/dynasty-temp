# A sample Guardfile
# More info at https://github.com/guard/guard#readme


guard 'spork',
    :cucumber_env => { 'RAILS_ENV' => 'test' },
    :rspec_env => { 'RAILS_ENV' => 'test' },
    :jasmine_env => { 'RAILS_ENV' => 'test' },
    :wait => 60 do
    watch('config/application.rb')
    watch('config/environment.rb')
    watch(%r{^config/environments/.+\.rb$})
    watch(%r{^config/initializers/.+\.rb$})
    watch('Gemfile')
    watch('Gemfile.lock')
    watch('spec/spec_helper.rb') { :rspec }
    watch(%r{features/support/}) { :cucumber }
    watch(%r{^spec/factories/.+\.rb})
end

# Make sure this guard is ABOVE any other guards using assets such as jasmine-headless-webkit
# It is recommended to make explicit list of assets in `config/application.rb`
# config.assets.precompile = ['application.js', 'application.css', 'all-ie.css']


    guard 'rails-assets', :cli => "--drb" do
        watch(%r{^app/assets/.+$})
        watch('config/application.rb')
    end
    guard 'livereload', :cli => "--drb" do
        watch(%r{app/views/.+\.(erb|haml|slim)})
        watch(%r{app/helpers/.+\.rb})
        watch(%r{public/.+\.(css|js|html)})
        watch(%r{config/locales/.+\.yml})
        # Rails Assets Pipeline
        watch(%r{(app|vendor)/assets/\w+/(.+\.(css|js|html)).*})  { |m| "/assets/#{m[2]}" }
    end




    guard 'bundler', :cli => "--drb"  do
        watch('Gemfile')
        # Uncomment next line if Gemfile contain `gemspec' command
        # watch(/^.+\.gemspec/)
    end







guard 'rspec', :version => 2, :cli => "--drb" do
    watch(%r{^spec/.+_spec\.rb$})
    watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
    watch('spec/spec_helper.rb')  { "spec" }

    # Rails example
    watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
    watch(%r{^app/(.*)(\.erb|\.haml)$})                 { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
    watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] }
    watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }
    watch('config/routes.rb')                           { "spec/routing" }
    watch('app/controllers/application_controller.rb')  { "spec/controllers" }

    # Capybara request specs
    watch(%r{^app/views/(.+)/.*\.(erb|haml)$})          { |m| "spec/requests/#{m[1]}_spec.rb" }
end

guard 'cucumber', :cli => "--drb" do
    watch(%r{^features/.+\.feature$})
    watch(%r{^features/support/.+$})          { 'features' }
    watch(%r{^features/step_definitions/(.+)_steps\.rb$}) { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'features' }
end

# TODO: Figure out how to get around the problem with phantomjs using an old libpng, then uncomment this
guard 'jasmine', :cli => "--drb" do
    watch(%r{spec/javascripts/spec\.(js\.coffee|js|coffee)$})         { "spec/javascripts" }
    watch(%r{spec/javascripts/.+_spec\.(js\.coffee|js|coffee)$})
    watch(%r{app/assets/javascripts/(.+?)\.(js\.coffee|js|coffee)$})  { |m| "spec/javascripts/#{m[1]}_spec.#{m[2]}" }
    watch(%r{vendor/assets/javascripts/spine/(.+?)\.(js\.coffee|js|coffee)$}) { |m|
        "vendor/assets/javascripts/spine/test/specs/#{m[1]}.js"
    }
end











