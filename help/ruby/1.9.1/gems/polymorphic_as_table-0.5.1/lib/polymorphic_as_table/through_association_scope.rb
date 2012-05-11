module PolymorphicAsTable
  module ThroughAssociationScope
    def self.included(base)
      base.class_eval do
        def construct_owner_attributes(reflection)
          if as = reflection.options[:as]
            { "#{as}_id" => @owner.id,
              "#{as}_type" => @owner.class.base_class.table_name }
          else
            { reflection.primary_key_name => @owner.id }
          end
        end

        def construct_quoted_owner_attributes(reflection)
          if as = reflection.options[:as]
            { "#{as}_id"   => @owner.class.quote_value(
                @owner[reflection.active_record_primary_key],
                reflection.klass.columns_hash["#{as}_id"]),
              "#{as}_type" => reflection.klass.quote_value(
                @owner.class.base_class.table_name.to_s,
                reflection.klass.columns_hash["#{as}_type"]) }
          elsif reflection.macro == :belongs_to
            { reflection.klass.primary_key => @owner.class.quote_value(@owner[reflection.primary_key_name]) }
          else
            column = @owner.class.columns_hash[reflection.active_record_primary_key]

            { reflection.primary_key_name => @owner.class.quote_value(@owner[reflection.active_record_primary_key], column) }
          end
        end
        def construct_joins(custom_joins = nil)
          polymorphic_join = nil
          if @reflection.source_reflection.macro == :belongs_to
            reflection_primary_key = @reflection.source_reflection.options[:primary_key] ||
              @reflection.klass.primary_key
            source_primary_key = @reflection.source_reflection.primary_key_name
            if @reflection.options[:source_type]
              polymorphic_join = "AND %s.%s = %s" % [
                @reflection.through_reflection.quoted_table_name, "#{@reflection.source_reflection.options[:foreign_type]}",
                @owner.class.quote_value(@reflection.options[:source_type])
              ]
            end
          else
            reflection_primary_key = @reflection.source_reflection.primary_key_name
            source_primary_key     = @reflection.source_reflection.options[:primary_key] ||
              @reflection.through_reflection.klass.primary_key
            if @reflection.source_reflection.options[:as]
              polymorphic_join = "AND %s.%s = %s" % [
                @reflection.quoted_table_name, "#{@reflection.source_reflection.options[:as]}_type",
                @owner.class.quote_value(@reflection.through_reflection.klass.table_name)
              ]
            end
          end

          "INNER JOIN %s ON %s.%s = %s.%s %s #{@reflection.options[:joins]} #{custom_joins}" % [
            @reflection.through_reflection.quoted_table_name,
            @reflection.quoted_table_name, reflection_primary_key,
            @reflection.through_reflection.quoted_table_name, source_primary_key,
            polymorphic_join
          ]
        end
      end
    end
  end
end
