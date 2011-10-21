module PolymorphicAsTable
  module BelongsToAssociation
    def self.included(base)
      base.class_eval do
        def association_class
          @owner[@reflection.options[:foreign_type]].present? ? @owner[@reflection.options[:foreign_type]].classify.constantize : nil
        end
      end
    end
  end
end
