class UserObserver < ActiveRecord::Observer
    def before_update(user)
        user.phone = user.phone.gsub(/[^0-9A-Za-z]/, '') if user.phone
    end

    def after_create(user)
        address = user.build_address
        address.save
    end
end
