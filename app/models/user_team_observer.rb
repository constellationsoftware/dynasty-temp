class UserTeamObserver < ActiveRecord::Observer
    def after_create(model)
        42.times do
            model.picks.create
        end
    end
end
