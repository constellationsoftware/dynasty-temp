module Validators
    class PlayerTeamRecord < ActiveModel::Validator
        def validate(record)
            # make sure there are positions available in the starting lineup
            if record.depth == 1
                player = Player.joins{position}.includes{position}.where{id == record.player_id}.first
                puts player.inspect
                position_allowance = Player.position_quantities[record.depth][(player.position.designation).to_sym][(player.position.abbreviation).to_sym]
                position_count = record.players_in_position(record.depth).count
                record.errors[:depth] << "Your starting lineup has too many #{player.position.name.pluralize}." unless position_count < position_allowance
            end
        end
    end
end
