class Forgery::Name
    def self.team_name(unique = false)
        dictionaries[:team_names].send(unique ? :unique : :random).try :unextend
    end
end
