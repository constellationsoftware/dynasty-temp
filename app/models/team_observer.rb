class TeamObserver < ActiveRecord::Observer
    def before_create(team)
        # create GUID
        uuid = UUIDTools::UUID.timestamp_create
        team.uuid = uuid.raw

        # set initial balance
        team.balance = Settings.team.initial_balance
    end
end
