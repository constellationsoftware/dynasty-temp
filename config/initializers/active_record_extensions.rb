module SingleTableInheritanceIdentity
    def self.included(base); base.extend(ClassMethods) end

    module ClassMethods
        attr_accessor :identity

        def inherited(base) #:nodoc:
            super(base)
            identity = nil
        end

        def type_condition(table = arel_table)
            sti_column = table[inheritance_column.to_sym]
            sti_names = ([self] + descendants).map { |model| model.identity.nil? ? model.sti_name : model.identity.to_s }

            sti_column.in(sti_names)
        end

        def find_sti_class(type_name)
            identity.nil? ? super(type_name) : self
        end
    end
end
ActiveRecord::Base.send(:include, SingleTableInheritanceIdentity)

class ActiveRecord::Reflection::AssociationReflection
    def identity
        @identity ||= self.options[:identity] || self.klass.name
    end
end

class ActiveRecord::Associations::Builder::HasOne
    self.valid_options += [ :identity ]
end

class ActiveRecord::Associations::Builder::HasMany
    self.valid_options += [ :identity ]
end

class ActiveRecord::Associations::Builder::HasAndBelongsToMany
    self.valid_options += [ :identity ]
end

class ActiveRecord::Associations::AssociationScope
    def add_constraints(scope)
        tables = construct_tables

        chain.each_with_index do |reflection, i|
            table, foreign_table = tables.shift, tables.first

            if reflection.source_macro == :has_and_belongs_to_many
                join_table = tables.shift

                scope = scope.joins(join(
                    join_table,
                    table[reflection.association_primary_key].
                        eq(join_table[reflection.association_foreign_key])
                ))

                table, foreign_table = join_table, tables.first
            end

            if reflection.source_macro == :belongs_to
                if reflection.options[:polymorphic]
                    key = reflection.association_primary_key(klass)
                else
                    key = reflection.association_primary_key
                end

                foreign_key = reflection.foreign_key
            else
                key = reflection.foreign_key
                foreign_key = reflection.active_record_primary_key
            end

            conditions = self.conditions[i]
            if reflection == chain.last
                scope = scope.where(table[key].eq(owner[foreign_key]))

                if reflection.type
                    scope = scope.where(table[reflection.type].eq(reflection.identity)) # overridden
                end

                conditions.each do |condition|
                    if options[:through] && condition.is_a?(Hash)
                        condition = {table.name => condition}
                    end

                    scope = scope.where(interpolate(condition))
                end
            else
                constraint = table[key].eq(foreign_table[foreign_key])

                if reflection.type
                    type = chain[i + 1].klass.base_class.name
                    constraint = constraint.and(table[reflection.type].eq(reflection.identity)) # overridden
                end

                scope = scope.joins(join(foreign_table, constraint))

                unless conditions.empty?
                    scope = scope.where(sanitize(conditions, table))
                end
            end
        end

        scope
    end
end
