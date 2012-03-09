http_path = '/'
$rails_root      = File.join(File.dirname(__FILE__), '..', '..', '..', '..')
project_path    = File.join($rails_root, 'public', 'draft', 'resources')
css_path        = File.join(project_path, 'css')
sass_path       = File.join(project_path, 'sass')
$sass_path      = sass_path
images_path     = File.join(project_path, 'images')
relative_assets = true

# $ext_path: This should be the path of the Ext JS SDK relative to this file
$ext_path = File.join($rails_root, 'vendor', 'assets', 'javascripts', 'extjs')

# output_style: The output style for your compiled CSS
# nested, expanded, compact, compressed
# More information can be found here http://sass-lang.com/docs/yardoc/file.SASS_REFERENCE.html#output_style
output_style = :expanded

# We need to load in the Ext4 themes folder, which includes all it's default styling, images, variables and mixins
#load project_path
load File.join($ext_path, 'resources', 'themes')

sass_options = { :debug_info => false } # by Compass.app
