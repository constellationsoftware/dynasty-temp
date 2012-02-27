module Validators
    class PlayerTeamRecord < ActiveModel::Validator
        def validate(record)
            if record.depth == 1
                # figure out which slot it goes in (other than your mom's)
                filled_slots = Lineup.select{ id }.joins{ player_teams }.where{ player_teams.user_team_id == my{ record.user_team_id } }
                empty_slot = Lineup.where{ (position_id == my{ record.position_id }) & (id << filled_slots) }.first

                if empty_slot
                    record.lineup = empty_slot
                else
                    record.errors[:depth] << "Your starting lineup has too many #{record.player.position.name.pluralize}."
                    record.errors[:starter] << "It is #{record.player.name.full_name}s bye week." if self.class.bye_week?(record)                    
                end
            else
                record.lineup = nil
            end
        end

        def self.starter_positions_filled?(record)
            position = record.player.position
            # free slots for starters
            slots = Player.free_slots()[1][position.designation].to_i
            position_counts = Player.get_position_counts(record.user_team_id, record.depth, position.designation)

            # compute the total filled slots for this designation
            counts = position_counts.collect{ |x| x.count if x.designation == position.designation }.compact
            player_sum = counts.empty? ? 0 : counts.reduce(:+)

            # number of filled slots for this position and designation and total
            position_count = position_counts.find do |x|
                x.abbreviation == position.abbreviation
            end
            position_count = position_count.count unless position_count.nil?
            position_allowance = Player.position_quantities[1][(position.designation).to_sym][(position.abbreviation).to_sym]
            # extra allowable for valid flex positions
            position_allowance += 1 if Player.flex_positions.include?(position.abbreviation.to_sym) && (player_sum < slots) && !(position_allowance.nil?)

            #puts "sum: #{player_sum}, slots: #{slots}, pos_count: #{position_count}, max: #{position_allowance}"
            !(player_sum < slots && (position_allowance.nil? || position_count < position_allowance))
        end

        def self.bye_week?(record)
            the_week = Clock.first.week+1
            player_bye_week = record.player.flatten[:bye_week]
            the_week == player_bye_week
        end
    end
end
