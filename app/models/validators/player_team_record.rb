module Validators
    class PlayerTeamRecord < ActiveModel::Validator
        def validate(record)
            if record.depth == 1
                # figure out which slot it goes in (other than your mom's)
                position_id = record.player.position_link.position_id
                previous_options = Lineup.reflect_on_association(:player_teams).options[:conditions]
                Lineup.reflect_on_association(:player_teams).options[:conditions] = "#{record.class.table_name}.team_id = #{record.team_id}"
                empty_slots = Lineup.joins{[ position, position.positions.outer, player_teams.outer ]}
                    .where{ player_teams.player_id == nil }
                    .where{ (position_id == my{ position_id }) }
=begin
                filled_slots = Lineup.select{ id }.joins{ player_teams }.where{ player_teams.team_id == my{ record.team_id } }
                offensive_flex_positions = Position.select{ id }.where{ (designation == 'o') & (flex_position_id != nil) }
                defensive_flex_positions = Position.select{ id }.where{ (designation == 'd') & (flex_position_id != nil) }
                empty_slot = Lineup.joins{[ position ]}.where{ id << filled_slots }
                    .where{ (position_id == my{ record.position_id }) | ((position.designation == 'o') & (position_id >> offensive_flex_positions)) | ((position.designation == 'd') & (position_id >> defensive_flex_positions)) }.first
=end
                if empty_slots.empty?
                    record.errors[:depth] << "Your starting lineup has too many #{record.player.position.name.pluralize}."
                    record.errors[:starter] << "It is #{record.player.name.full_name}s bye week." if self.class.bye_week?(record)
                else
                    record.lineup = empty_slots.first
                end
                Lineup.reflect_on_association(:player_teams).options[:conditions] = previous_options
            else
                record.lineup = nil
            end
        end

        def self.starter_positions_filled?(record)
            position = record.player.position
            # free slots for starters
            slots = Player.free_slots()[1][position.designation].to_i
            position_counts = Player.get_position_counts(record.team_id, record.depth, position.designation)

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
