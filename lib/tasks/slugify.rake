module Rake
  module TaskArgs
    def args
      ARGV.find {|l| l =~ /#{name}\[([^\]]+)/}
      $1
    end

    def arg_list
      args.split(/,/) if args
    end
  end

  # mixin enables 'rest args', or a variable-length argument list, on tasks
  class Task
    include TaskArgs
  end
end

desc 'Creates slugs for existing objects. Usage: rake slugify[model1,model2,...]'
task :slugify => :environment do |cmd|
	#puts "args: #{cmd.arg_list.inspect}"
	cmd.arg_list.each do |model|
		@model = model.constantize
		@model.find_each(&:save)
	end
end
