class ApplicationController < ActionController::Base
    #protect_from_forgery :except => [ :auth, :post_message ]
    #before_filter :authenticate_user! :except => [:people, :persons]
    include UrlHelper
    helper_method :get_alert_style_by_type

    # Session Storage using ActiveRecord
    session :session_key => '_dynasty_session_id'


    #
    # Don't even think about using this without Inherited Resources
    #
    protected
        def update_and_return(context)
            begin
                eval "update! { |format| format.html { redirect_to :back } }", context
            rescue Exception => e
                raise "I WARNED YOU ABOUT CALLING #{__method__} WITHOUT INHERITING FROM InheritedResources::Base!!!!! I TOLD YOU DOG!"
            end
        end

        def get_alert_style_by_type(type)
            case type
                when :success
                    'success'
                when :warning, :alert
                    'warning'
                when :failure, :error
                    'error'
            end
        end
end
