desc "Clean up polymorphic tables from XMLteam"
task :cleaner => :environment do
    DisplayName.update_all("entity_type = 'Team'", "entity_type LIKE '%teams%'")
    DisplayName.update_all("entity_type = 'Person'", "entity_type LIKE '%persons%'")
    DisplayName.update_all("entity_type = 'Affiliation'", "entity_type LIKE '%affiliations%'")
    PersonPhase.update_all("membership_type = 'Team'", "membership_type LIKE '%teams%'")
    PersonPhase.update_all("membership_type = 'Person'", "membership_type LIKE '%persons%'")
    PersonPhase.update_all("membership_type = 'Affiliation'", "membership_type LIKE '%affiliations%'")
    PersonPhase.update_all("phase_type = 'Team'", "phase_type LIKE '%team%'")
    PersonPhase.update_all("phase_type = 'Professional'", "phase_type LIKE '%professional%'")
    PersonPhase.update_all("phase_type = 'Entry'", "phase_type LIKE '%entry%'")
    PersonPhase.update_all("subphase_type = 'Rookie'", "subphase_type LIKE '%rookie%'")
    PersonPhase.update_all("subphase_type = 'Normal'", "subphase_type LIKE '%normal%'")
    Affiliation.update_all("affiliation_type = 'Sport'", "affiliation_type LIKE '%sport'")
    Affiliation.update_all("affiliation_type = 'Conference'", "affiliation_type LIKE '%conference'")
    Affiliation.update_all("affiliation_type = 'Division'", "affiliation_type LIKE '%division'")
    Affiliation.update_all("affiliation_type = 'League'", "affiliation_type LIKE '%league'")
    OutcomeTotal.update_all("outcome_holder_type = 'Team'", "outcome_holder_type LIKE '%teams'")
    ParticipantsEvent.update_all("participant_type = 'Person'", "participant_type LIKE '%persons'")
    ParticipantsEvent.update_all("participant_type = 'Team'", "participant_type LIKE '%teams'")


    Stat.update_all("stat_holder_type = 'Team'", "stat_holder_type LIKE '%teams%'")
    Stat.update_all("stat_holder_type = 'Person'", "stat_holder_type LIKE '%persons%'")
    Stat.update_all("stat_holder_type = 'Affiliation'", "stat_holder_type LIKE '%affiliations%'")

    Stat.update_all("stat_coverage_type = 'Event'", "stat_coverage_type LIKE '%events%'")
    Stat.update_all("stat_coverage_type = 'SubSeason'", "stat_coverage_type LIKE '%sub_seasons%'")
    Stat.update_all("stat_coverage_type = 'Affiliation'", "stat_coverage_type LIKE '%affiliations%'")


    Stat.update_all("stat_coverage_type = 'Event'", "stat_coverage_type LIKE '%events%'")
    Stat.update_all("stat_coverage_type = 'SubSeason'", "stat_coverage_type LIKE '%sub_seasons%'")
    Stat.update_all("stat_coverage_type = 'Affiliation'", "stat_coverage_type LIKE '%affiliations%'")

    Stat.update_all("stat_repository_type = 'AmericanFootballOffensiveStat'", "stat_repository_type LIKE '%american_football_offensive_stats'")
    Stat.update_all("stat_repository_type = 'AmericanFootballPassingStat'", "stat_repository_type LIKE '%american_football_passing_stats'")
    Stat.update_all("stat_repository_type = 'AmericanFootballDefensiveStat'", "stat_repository_type LIKE '%american_football_defensive_stats'")
    Stat.update_all("stat_repository_type = 'AmericanFootballFumblesStat'", "stat_repository_type LIKE '%american_football_fumbles_stats'")
    Stat.update_all("stat_repository_type = 'AmericanFootballPenaltiesStat'", "stat_repository_type LIKE '%american_football_penalties_stats'")
    Stat.update_all("stat_repository_type = 'AmericanFootballRushingStat'", "stat_repository_type LIKE '%american_football_rushing_stats'")
    Stat.update_all("stat_repository_type = 'AmericanFootballSacksAgainstStat'", "stat_repository_type LIKE '%american_football_sacks_against_stats'")
    Stat.update_all("stat_repository_type = 'AmericanFootballScoringStat'", "stat_repository_type LIKE '%american_football_scoring_stats'")
    Stat.update_all("stat_repository_type = 'AmericanFootballSpecialTeamsStat'", "stat_repository_type LIKE '%american_football_special_teams_stats'")
    Stat.update_all("stat_repository_type = 'CoreStat'", "stat_repository_type LIKE '%core_stats'")


    @stats = Stat.all; nil
    @stats.each do |s|
        s.stat_repository_type = s.stat_repository_type.classify
        s.stat_coverage_type = s.stat_coverage_type.classify
        s.stat_membership_type = s.stat_membership_type.classify
        s.save!
    end; nil

    @stats = Stat.all; nil
    @stats.each do |s|
        s.stat_repository_type.classify
        s.save!
    end; nil


    puts "The tables are cleaned up!"
end
