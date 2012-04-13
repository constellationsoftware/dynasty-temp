class ApplicationController < ActionController::Base
    #protect_from_forgery :except => [ :auth, :post_message ]
    #before_filter :authenticate_user! :except => [:people, :persons]
    include UrlHelper
    helper_method :get_alert_style_by_type


    #
    # Accepts an array of "sorter" hashes.
    # A "sorter" hash, as defined in Ext JS, consists of "property" and "direction" keys
    #
    has_scope :sorters, do |controller, scope, value|
        begin
            sorters = JSON.parse(value)
        rescue
            raise "Sorter object could not be parsed. Expected a JSON-encoded array of objects with 'property' and 'direction' keys, got #{value}."
        end
        sort_str = sorters.collect{ |sorter|
            sort_param = controller.sort_param_from_chain(sorter['property'])
            sort_direction = sorter['direction'].upcase === 'DESC' ? 'DESC' : 'ASC'
            "#{sort_param[:klass].table_name}.#{sort_param[:attribute]} #{sort_direction}"
        }.join(', ')
        scope.order(sort_str)
    end

    has_scope :filters, do |controller, scope, value|
        model_klass = controller.class.resource_class
        begin
            filters = JSON.parse(value)
        rescue
            raise "Filter object could not be parsed. Expected a JSON-encoded array of objects with 'property' and 'value' keys, got #{value}."
        end
        filters.each do |filter|
            filter_param = controller.sort_param_from_chain(filter['property'])
            filter_method = "filter_by_#{filter_param[:attribute]}"
            if model_klass.respond_to? filter_method
                scope = scope.send(filter_method, filter['value'])
            else
                raise "Filter method for #{filter['property']} on #{model_klass.to_s.titleize.downcase.pluralize} does not exist."
            end
        end
        scope
    end


    protected
        def get_alert_style_by_type(type)
            case type
                when :notice; 'notice'
                when :success; 'success'
                when :warning, :alert; 'warning'
                when :failure, :error; 'error'
            end
        end

        def sort_param_from_chain(value)
            association_chain = value.split('.')
            attribute = association_chain.pop
            # follow the association chain to its end so we can get the table name
            klass = association_chain.inject(self.class.resource_class) do |klass, value|
                association = klass.reflect_on_association(value.to_sym)
                association.klass
            end
            { :klass => klass, :attribute => attribute }
        end

        # Defines "sub-header" actions that are iterated on to generate links for the sub-header
        # within a page (if applicable)
        def self.sub_pages(*pages)
            class_eval <<-SET_SUB_PAGES, __FILE__, __LINE__
                def set_sub_pages
                    @sub_pages = #{pages}
                end
                protected :set_sub_pages
            SET_SUB_PAGES
            before_filter :set_sub_pages
        end
end
