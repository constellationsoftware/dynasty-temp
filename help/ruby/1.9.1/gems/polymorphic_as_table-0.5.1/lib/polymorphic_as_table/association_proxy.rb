module PolymorphicAsTable
  module AssociationProxy
    def self.included(base)
      base.class_eval do
        def set_belongs_to_association_for(record)
          if @reflection.options[:as]
            record["#{@reflection.options[:as]}_id"]   = @owner.id unless @owner.new_record?
            record["#{@reflection.options[:as]}_type"] = @owner.class.base_class.table_name
          else
            unless @owner.new_record?
              primary_key = @reflection.options[:primary_key] || :id
              record[@reflection.primary_key_name] = @owner.send(primary_key)
            end
          end
        end
      end
    end
  end
end
