class PhoneInput < Formtastic::Inputs::PhoneInput
=begin
    def to_html
        input_wrapping do
            label_html <<
            builder.phone_field(method, input_html_options.merge(
                :value => @object.method.number_to_phone
            ))
        end
    end
=end
end
