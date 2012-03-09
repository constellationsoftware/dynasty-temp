=begin
$ext_path = nil
Compass.configuration do |config|
    config.project_type = :rails
    config.project_path = Rails.root
    config.http_path = '/'
    environment = Compass::AppIntegration::Rails.env

    $ext_path = File.join(config.project_path, 'vendor', 'assets', 'javascripts', 'extjs')
    require File.join($ext_path, 'resources', 'themes', 'compass_init')
end
=end
