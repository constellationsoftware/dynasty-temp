module PolymorphicAsTable
  require 'polymorphic_as_table/association_proxy'
  require 'polymorphic_as_table/belongs_to_association'
  require 'polymorphic_as_table/has_many_association'
  require 'polymorphic_as_table/has_one_association'
  require 'polymorphic_as_table/through_reflection'
  require 'polymorphic_as_table/through_association_scope'

  module ClassMethods
    def has_polymorphic_as_table
      ActiveRecord::Associations::AssociationProxy.send(
        :include, PolymorphicAsTable::AssociationProxy)
      ActiveRecord::Associations::HasOneAssociation.send(
        :include, PolymorphicAsTable::HasOneAssociation)
      ActiveRecord::Associations::HasManyAssociation.send(
        :include, PolymorphicAsTable::HasManyAssociation)
      ActiveRecord::Associations::ThroughAssociationScope.send(
        :include, PolymorphicAsTable::ThroughAssociationScope)
      ActiveRecord::Reflection::ThroughReflection.send(
        :include, PolymorphicAsTable::ThroughReflection)

      class << self
        def sti_name
          table_name
        end
      end
    end

    def is_polymorphic_as_table
      ActiveRecord::Associations::AssociationProxy.send(
        :include, PolymorphicAsTable::AssociationProxy)
      ActiveRecord::Associations::BelongsToPolymorphicAssociation.send(
        :include, PolymorphicAsTable::BelongsToAssociation)

      class << self
        def define_attribute_methods
          if super && @@association
            define_method("#{@@association}_type=") do |value|
              debugger
              write_attribute("#{@@association}_type", value.tableize)
            end

            define_method("#{@@association}_type") do
              read_attribute("#{@@association}_type").classify
            end

            define_method("#{@@association}=") do |association|
              write_attribute("#{@@association}", association)
              write_attribute("#{@@association}_type", association.class.to_s.tableize)
            end
          end
        end

        def belongs_to(association_id, options={})
          @@association = association_id
          super
        end
      end
    end
  end

  def self.included(base)
    base.extend(ClassMethods)
  end
end

ActiveRecord::Base.send(:include, PolymorphicAsTable)
