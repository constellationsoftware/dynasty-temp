module NavigationHelpers
    def path_to(page_name)
        case page_name
        when /home/
            root_url
        when /user (sign|log)[ -]?in/
            new_user_session_url
        # Add more page name => path mappings here
        else
            if path = match_rails_path_for(page_name)
                path
            else
                raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
                "Now, go and add a mapping in features/support/paths.rb"
            end
        end
    end

    def match_rails_path_for(page_name)
        send "#{page_name.gsub(" ", "_")}_url" rescue nil
    end
end
World(NavigationHelpers)
