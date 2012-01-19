class ApplicationController < ActionController::Base
    #protect_from_forgery :except => [ :auth, :post_message ]
    #before_filter :authenticate_user! :except => [:people, :persons]
    include UrlHelper

    #
    # Don't even think about using this without Inherited Resources
    #
    def update_and_return(context)
        begin
            eval "update! { |format| format.html { redirect_to :back } }", context
        rescue Exception => e
            raise "I WARNED YOU ABOUT CALLING #{__method__} WITHOUT INHERITING FROM InheritedResources::Base!!!!! I TOLD YOU DOG!"
        end
    end
end
