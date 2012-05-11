class BooleanInput < Formtastic::Inputs::BooleanInput
    # Adds consideration of "checked" option to override defaults
    def check_box_html
        template.check_box_tag("#{object_name}[#{method}]", checked_value, options.has_key?(:checked) ? options[:checked] : checked?, input_html_options)
    end
end
