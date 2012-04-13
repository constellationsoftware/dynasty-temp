unless Rails.env.production?
    require 'fabrication'
    Fabrication.configure do |config|
        fabricator_dir = 'spec/fabricators'
    end
end
