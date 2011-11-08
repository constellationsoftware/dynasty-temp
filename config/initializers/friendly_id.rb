FriendlyId.defaults do |config|
  config.base = :name
  config.use :slugged
  config.slug_column = :slug
end
