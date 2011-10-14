desc "Clean up polymorphic tables from XMLteam"
task :cleaner  => :environment do
    DisplayName.update_all("entity_type = 'Team'", "entity_type LIKE '%teams%'")
    DisplayName.update_all("entity_type = 'Person'", "entity_type LIKE '%persons%'")
    DisplayName.update_all("entity_type = 'Affiliation'", "entity_type LIKE '%affiliations%'")

    Stat.update_all("stat_holder_type = 'Team'", "stat_holder_type LIKE '%teams%'")
    Stat.update_all("stat_holder_type = 'Person'", "stat_holder_type LIKE '%persons%'")
    Stat.update_all("stat_holder_type = 'Affiliation'", "stat_holder_type LIKE '%affiliations%'")

    Affiliation.update_all("affiliation_type = 'Sport'", "affiliation_type LIKE '%sport'")
    Affiliation.update_all("affiliation_type = 'Conference'", "affiliation_type LIKE '%conference'")
    Affiliation.update_all("affiliation_type = 'Division'", "affiliation_type LIKE '%division'")
    Affiliation.update_all("affiliation_type = 'League'", "affiliation_type LIKE '%league'")

    OutcomeTotal.update_all("outcome_holder_type = 'Team'", "outcome_holder_type LIKE '%teams'")
   
    ParticipantsEvent.update_all("participant_type = 'Person'", "participant_type LIKE '%persons'")
    ParticipantsEvent.update_all("participant_type = 'Team'", "participant_type LIKE '%team'")

    puts "The tables are cleaned up!"
end