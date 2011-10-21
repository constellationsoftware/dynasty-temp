module PolymorphicAsTable
  module HasOneAssociation
    def self.included(base)
      base.class_eval do
        def find_target
          options = @reflection.options.dup
          (options.keys - [:select, :order, :include, :readonly]).each do |key|
            options.delete key
          end
          options[:conditions] = @finder_sql

          the_target = @reflection.klass.find(:first, options)
          set_inverse_instance(the_target, @owner)
          the_target
        end
        def construct_sql
          case
          when @reflection.options[:as]
            @finder_sql =
              "#{@reflection.quoted_table_name}.#{@reflection.options[:as]}_id = #{owner_quoted_id} AND " +
              "#{@reflection.quoted_table_name}.#{@reflection.options[:as]}_type = #{@owner.class.quote_value(@owner.class.base_class.table_name)}"
          else
            @finder_sql = "#{@reflection.quoted_table_name}.#{@reflection.primary_key_name} = #{owner_quoted_id}"
          end
          @finder_sql << " AND (#{conditions})" if conditions
        end
      end
    end
  end
end
