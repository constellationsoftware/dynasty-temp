require 'app_responder'

class ApplicationController < ActionController::Base
    class << self; attr_accessor :resource_klass end
    self.responder = AppResponder
    #protect_from_forgery :except => [ :auth, :post_message ]
    helper_method :get_alert_style_by_type

    helper  :all
    before_filter :set_current_clock
    before_filter :authenticate_user!, :except => [:register, :research ]
    before_filter :check_registered_league, :except => [ :register_league ]

    respond_to :html

    has_scope :page
    has_scope :per

    has_scope :columns do |controller, scope, value|
        columns = JSON.parse(value).collect do |column|
            "#{column}.as('`#{column}`')"
        end
        scope.select{ instance_eval("[#{columns.compact.join(',')}]") }
    end

    ##
    # Accepts an array of "sorter" hashes.
    # A "sorter" hash, as defined in Ext JS, consists of "property" and "direction" keys
    #
    has_scope :sorters do |controller, scope, value|
        begin
            sorters = JSON.parse(value)
        rescue
            raise "Sorter object could not be parsed. Expected a JSON-encoded array of objects with 'property' and 'direction' keys, got #{value}."
        end
        sort_str = sorters.collect do |sorter|
            property = sorter['property']
            direction = sorter['direction'].downcase === 'desc' ? 'desc' : 'asc'
            "#{property}.#{direction}"
        end
        scope.order{ instance_eval("[#{sort_str.join(',')}]") }
    end

    # TODO: very quick, very dirty. Requires method or scope called "filter_by_[whatever]" on the main resource
    # The problem with this is that we won't always be accessing these scopes through the same resource.
    # So if we want to filter on player.position one time and lineup.position on another, we have to write
    # the same thing twice.
    # Squeel has a compelling feature called "sifters" that allow you to essentially scope a scope anywhere along
    # the keypath, which DRYs things up a lot. Only problem is that we need to figure out a good flexible filtering API
    has_scope :filters do |controller, scope, value|
        begin
            filters = JSON.parse(value)
        rescue
            raise "Filter object could not be parsed. Expected a JSON-encoded array of objects with 'property' and 'value' keys, got #{value}."
        end
        filters.each do |filter|
            filter_method = "filter_by_#{filter['property']}"
            scope = scope.send(filter_method, filter['value'])
        end
        scope
    end

=begin
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

    def filter_resource(scope, property, value)
        filter_param = sort_param_from_chain(property)
        filter_method = "filter_by_#{filter_param[:attribute]}"
        if resource_class.respond_to? filter_method
            scope = scope.send(filter_method, value)
        else
            raise "Filter method for #{property} on #{resource_class.name.to_s.titleize.downcase.pluralize} does not exist."
        end
    end
=end

    protected
        # The registration steps are as follows:
        # 1. Initial registration
        # 2. Create/join a league
        # 3. Name your team
        def check_registered_league
            return unless current_user
            redirect_to '/register/league' if current_user.team.league_id.nil?
        end

        def get_alert_style_by_type(type)
            case type
                when :notice;
                    'alert-info'
                when :success;
                    'alert-success'
                when :warning, :alert;
                    'alert-info'
                when :failure, :error;
                    'alert-error'
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

        # Instantiates a clock for views
        def set_current_clock
            if session[:clock].nil?
                @clock = Clock.first
                session[:clock] = @clock
            end
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
