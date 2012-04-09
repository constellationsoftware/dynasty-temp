# Define extensions to framework base classes

module ActiveRecordExtensions
    def self.included(base)
        base.extend(ClassMethods)
    end

    # add instance methods here

    module ClassMethods
    end
end

# include the extension 
ActiveRecord::Base.send(:include, ActiveRecordExtensions)
