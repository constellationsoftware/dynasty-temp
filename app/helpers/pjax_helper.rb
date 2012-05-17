class PjaxHelper

    def partial(page, options{})
        haml :"_#{page}", options.merge!{:layout => false}
    end