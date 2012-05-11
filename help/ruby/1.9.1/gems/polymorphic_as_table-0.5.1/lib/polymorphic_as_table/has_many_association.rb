module PolymorphicAsTable
  module HasManyAssociation
    def self.included(base)
      base.class_eval do
        def construct_sql
          case
          when @reflection.options[:finder_sql]
            @finder_sql = interpolate_and_sanitize_sql(@reflection.options[:finder_sql])

          when @reflection.options[:as]
            @finder_sql =
              "#{@reflection.quoted_table_name}.#{@reflection.options[:as]}_id = #{owner_quoted_id} AND " +
              "#{@reflection.quoted_table_name}.#{@reflection.options[:as]}_type = #{@owner.class.quote_value(@owner.class.base_class.table_name)}"
            @finder_sql << " AND (#{conditions})" if conditions

          else
            @finder_sql = "#{@reflection.quoted_table_name}.#{@reflection.primary_key_name} = #{owner_quoted_id}"
            @finder_sql << " AND (#{conditions})" if conditions
          end

          construct_counter_sql
        end
      end
    end
  end
end
