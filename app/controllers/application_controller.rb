require 'app_responder'

class ApplicationController < ActionController::Base
    class << self; attr_accessor :resource_klass end
    self.responder = AppResponder
    #protect_from_forgery :except => [ :auth, :post_message ]
    include UrlHelper
    helper_method :get_alert_style_by_type

    respond_to :html

    has_scope :page
    has_scope :per

    #
    # Accepts an array of "sorter" hashes.
    # A "sorter" hash, as defined in Ext JS, consists of "property" and "direction" keys
    #
    has_scope :sorters do |controller, scope, value|
        begin
            sorters = JSON.parse(value)
        rescue
            raise "Sorter object could not be parsed. Expected a JSON-encoded array of objects with 'property' and 'direction' keys, got #{value}."
        end
        sort_str = sorters.collect { |sorter|
            sort_param = controller.sort_param_from_chain(sorter['property'])
            sort_direction = sorter['direction'].upcase === 'DESC' ? 'DESC' : 'ASC'
            "#{sort_param[:klass].table_name}.#{sort_param[:attribute]} #{sort_direction}"
        }.join(', ')
        scope.order(sort_str)
    end

    has_scope :filters do |controller, scope, value|
        model_klass = controller.class.resource_klass
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

    def sort_param_from_chain(value)
        association_chain = value.split('.')
        attribute = association_chain.pop
        # follow the association chain to its end so we can get the table name
        klass = association_chain.inject(self.class.resource_klass) do |klass, value|
            association = klass.reflect_on_association(value.to_sym)
            association.klass
        end
        { :klass => klass, :attribute => attribute }
    end

    protected
        def get_alert_style_by_type(type)
            case type
                when :notice;
                    'notice'
                when :success;
                    'success'
                when :warning, :alert;
                    'warning'
                when :failure, :error;
                    'error'
            end
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

        def resource_class; self.class.resource_klass end

        def self.resource_class=(klass)
            raise 'Resource class must be an instance of Class' unless klass.is_a? Class
            self.resource_klass = klass
        end

    private
        # Hook called on inheritance.
        #
        def self.inherited(base) #:nodoc:
            super(base)
            base.send :initialize_resource_klass!
        end

        # Initialize resources class accessors and set their default values.
        #
        def self.initialize_resource_klass! #:nodoc:
            # First priority is the namespaced model, e.g. User::Group
            self.resource_klass ||= begin
                namespaced_class = self.name.sub(/Controller/, '').singularize
                namespaced_class.constantize
            rescue NameError
                nil
            end

            # Second priority is the top namespace model, e.g. EngineName::Article for EngineName::Admin::ArticlesController
            self.resource_klass ||= begin
                namespaced_classes = self.name.sub(/Controller/, '').split('::')
                namespaced_class = [namespaced_classes.first, namespaced_classes.last].join('::').singularize
                namespaced_class.constantize
            rescue NameError
                nil
            end

            # Third priority the camelcased c, i.e. UserGroup
            self.resource_klass ||= begin
                camelcased_class = self.name.sub(/Controller/, '').gsub('::', '').singularize
                camelcased_class.constantize
            rescue NameError
                nil
            end

            # Otherwise use the Group class, or fail
            self.resource_klass ||= begin
                class_name = self.controller_name.classify
                class_name.constantize
            rescue NameError => e
                raise unless e.message.include?(class_name)
                nil
            end
        end
end
