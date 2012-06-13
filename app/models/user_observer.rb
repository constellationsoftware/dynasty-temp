class UserObserver < ActiveRecord::Observer
    def before_update(user)
   #     user.phone = user.phone.gsub(/[^0-9A-Za-z]/, '') if user.phone && user.phone.is_a? String
    end

    def after_create(user)
        #address = user.build_address
        #address.save
        #team = user.build_team
        #team.name = "#{user.username.capitalize}'s Team"
        #team.save!
    end
end
