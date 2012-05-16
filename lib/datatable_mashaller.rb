module DatatableMarshaller
    def self.included(base); base.extend(ClassMethods) end

    module ClassMethods
        def inherited(base)
            super(base)
            raise
            before_filter :process_datatable_params
        end
    end

    protected
        def process_datatable_params
            puts params.inspect
            raise
        end
end
