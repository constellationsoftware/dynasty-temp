# Don't panic, this is a tableless model, and only used to build out methods and validation
# in order to make building forms with Simple Form easier
class CreditCard
    extend ActiveModel::Naming
    extend ActiveModel::Translation
    include ActiveModel::Serialization
    include ActiveModel::Validations

    attr_accessor :first_name,
                  :last_name,
                  :email,
                  :phone,
                  :amount,
                  :card_num,
                  :card_code,
                  :expiration_month,
                  :expiration_day,
                  :address,
                  :city,
                  :state,
                  :zip

    validates_presence_of :first_name, :last_name, :amount, :card_num, :card_code, :expiration_month, :expiration_day, :address, :city, :state, :zip

    def initialize(attributes = {})
        attributes.each do |name, value|
            send "#{name}=", value
        end
    end

    def expiration_date
        expiration_month.rjust(2, '0') + expiration_day.rjust(2, '0')
    end

    def serialize
        {
            'x_last_name' => last_name,
            'x_first_name' => first_name,
            'x_email' => email,
            'x_phone' => phone,
            'x_amount' => amount,
            'x_card_num' => card_num,
            'x_card_code' => card_code,
            'x_exp_date' => expiration_date,
            'x_address' => address,
            'x_city' => city,
            'x_state' => state,
            'x_zip' => zip
        }
    end
end
