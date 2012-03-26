class Reserve
    include Singleton
=begin
    include ActiveModel::AttributeMethods
    include ActiveModel::Conversion
    extend ActiveModel::Naming

    def self.attributes(*names)
        attr_accessor *names
    end

    attributes :id

    def persisted?; false end
    def valid?; true end
=end
=begin
    include ActiveRecord::Inheritance
    include ActiveRecord::Associations
    include ActiveRecord::Reflection
    include ActiveRecord::AutosaveAssociation
    include ActiveRecord::Callbacks
    include ActiveModel::Validations

    def self.generated_feature_methods
        @generated_feature_methods ||= begin
            mod = const_set(:GeneratedFeatureMethods, Module.new)
            include mod
            mod
        end
    end

    def self.primary_key; 'id' end

    # returns 0 when it's looking for an ID
    def [](name); 0 end

    class_attribute :pluralize_table_names, :instance_writer => false
    self.pluralize_table_names = false

    def self.class_of_active_record_descendant(klass); Class end
=end

    #has_many :payments, :as => :receivable
    #has_many :receipts, :as => :payable
end
