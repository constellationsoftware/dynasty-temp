module ApplicationHelper
    def controller_base_name
        controller.class.name.tableize.gsub '_controllers', ''
    end

    ###
    # Friendly Session Forwarding
    #

    module SessionsHelper

        def redirect_back_or(default)
            redirect_to(session[:return_to] || default)
            clear_return_to
        end

        def store_location
            session[:return_to] = request.fullpath
        end

        private

        def clear_return_to
            session.delete(:return_to)
        end
    end

    ###
    # Outputs an inline tooltip with an icon
    # Usually used to output a quick help tooltip
    #
    # Icons can be found at http://twitter.github.com/bootstrap/base-css.html#icons
    # NOTE: The 'icon-' prefix is always added.
    #
    def tip_icon(text, icon = 'question-sign', options = {})
        options[:delay] = options[:delay].stringify_keys!.to_json if options.has_key?('delay') && options[:delay].is_a?(Hash)
        default_options = {
            :delay => ({ 'show' => 300, 'hide' => 100 }).to_json
        }
        options = options.merge! default_options
        render :partial => '/shared/tooltip_icon', :locals => { :text => text, :icon => "icon-#{icon}", :options => options }
    end

    def us_states
        [
            ['Alabama', 'AL'],
            ['Alaska', 'AK'],
            ['Arizona', 'AZ'],
            ['Arkansas', 'AR'],
            ['California', 'CA'],
            ['Colorado', 'CO'],
            ['Connecticut', 'CT'],
            ['Delaware', 'DE'],
            ['District of Columbia', 'DC'],
            ['Florida', 'FL'],
            ['Georgia', 'GA'],
            ['Hawaii', 'HI'],
            ['Idaho', 'ID'],
            ['Illinois', 'IL'],
            ['Indiana', 'IN'],
            ['Iowa', 'IA'],
            ['Kansas', 'KS'],
            ['Kentucky', 'KY'],
            ['Louisiana', 'LA'],
            ['Maine', 'ME'],
            ['Maryland', 'MD'],
            ['Massachusetts', 'MA'],
            ['Michigan', 'MI'],
            ['Minnesota', 'MN'],
            ['Mississippi', 'MS'],
            ['Missouri', 'MO'],
            ['Montana', 'MT'],
            ['Nebraska', 'NE'],
            ['Nevada', 'NV'],
            ['New Hampshire', 'NH'],
            ['New Jersey', 'NJ'],
            ['New Mexico', 'NM'],
            ['New York', 'NY'],
            ['North Carolina', 'NC'],
            ['North Dakota', 'ND'],
            ['Ohio', 'OH'],
            ['Oklahoma', 'OK'],
            ['Oregon', 'OR'],
            ['Pennsylvania', 'PA'],
            ['Puerto Rico', 'PR'],
            ['Rhode Island', 'RI'],
            ['South Carolina', 'SC'],
            ['South Dakota', 'SD'],
            ['Tennessee', 'TN'],
            ['Texas', 'TX'],
            ['Utah', 'UT'],
            ['Vermont', 'VT'],
            ['Virginia', 'VA'],
            ['Washington', 'WA'],
            ['West Virginia', 'WV'],
            ['Wisconsin', 'WI'],
            ['Wyoming', 'WY']
        ]
    end
end
