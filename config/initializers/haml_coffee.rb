unless Rails.env.production?
    #HamlCoffeeAssets::HamlCoffeeTemplate.name_filter = lambda { |n| n.sub /^templates\//, '' }
end
