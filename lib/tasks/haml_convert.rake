# RAILS_ROOT/lib/tasks/haml_convert.rake
 
 require 'haml'
 require 'haml/exec'
  
 namespace :haml do
   namespace :convert do
     desc "Convert all *.html.erb files to *.html.haml"
     task :html do
       Dir.glob("app/views/**/*.html.erb").each do |html|
         puts html + "..."
         Haml::Exec::HTML2Haml.new([html, html.gsub(".html.erb", ".html.haml")]).process_result
         File.delete(html)
       end
     end
 
     desc "Convert all *.html.erb_spec.rb files to *.html.haml_spec.rb"
     task :spec do
       Dir.glob("spec/views/**/*.html.erb_spec.rb").each do |oldname|
         puts oldname + "..."
         newname = oldname.gsub(".html.erb", ".html.haml")
         nf = File.open(newname, "w")
         File.open(oldname) do |of|
           of.each_line do |line|
             nf.puts line.gsub(".html.erb", ".html.haml")
           end
         end
         nf.close
         #File.delete(oldname)
       end
     end
   end
 end