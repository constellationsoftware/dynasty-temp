module PjaxHelper

    def partial(page, options={})
        haml "#{page}", options.merge!(:layout => false)
    end

    def title(str)
        @title = str
        nil
    end
end