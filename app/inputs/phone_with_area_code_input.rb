class PhoneWithAreaCodeInput
    include Formtastic::Inputs::Base
    include Formtastic::Inputs::Base::Timeish

    def initialize(builder, template, object, object_name, method, options)
        puts options
        super(builder, template, object, object_name, method, options)
    end

    def to_html
        input_wrapping do
            #label_html <<
            #builder.phone_field(method, input_html_options)
            fragments_wrapping do
                template.content_tag(:ol,
                    [:area_code, :phone].map do |fragment|
                        fragment_wrapping do
                            fragment_label_html(fragment) <<
                            fragment_input_html(fragment)
                        end
                    end.join.html_safe, # TODO is this safe?
                    { :class => 'fragments-group' } # TODO refactor to fragments_group_wrapping
                )
            end
        end
    end

    def fragments_wrapping(&block)
        template.capture(&block).html_safe
    end

    def fragment_label_html(fragment)
        text = fragment_label(fragment)
        text.blank? ? "".html_safe : template.content_tag(:label, text, :for => fragment_id(fragment))
    end

    def fragment_input_html(fragment)
        #opts = input_options.merge(:prefix => fragment_prefix, :field_name => fragment_name(fragment), :default => value, :include_blank => include_blank?)
        puts input_html_options.merge(:id => fragment_id(fragment)).inspect
        puts object_name.inspect
        builder.phone_field(method, input_html_options.merge(
            :id => fragment_id(fragment),
            :name => fragment_name(fragment)
        ))
    end

    def fragment_name(fragment)
        "#{object_name}[#{fragment.to_s}]"
    end

    def positions
        { :area_code => 1, :phone => 2 }
    end
end
