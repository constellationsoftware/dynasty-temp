module PolymorphicAsTable
  module ThroughReflection
    def self.included(base)
      base.class_eval do
        def klass
          @klass ||= active_record.send(:compute_type, class_name.classify)
        end
      end
    end
  end
end
