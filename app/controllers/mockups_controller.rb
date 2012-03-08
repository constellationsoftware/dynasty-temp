class MockupsController < ApplicationController

    def index
        @title = "Mockups Index"
    end

    def user_control_panel
        @title = "User Control Panel"
    end

    def team_control_panel
        @title = "Team Control Panel"
    end


    def login
        @title = "Login Mockup"
    end

    def signup
        @title = "New User Signup"
    end

    def signup_2
        @title = "New User Signup"
    end

    def signup_3
        @title = "New User Signup"
    end

    def player_research
        @title = "Player Research"
    end
    def player_detail
        @title = "Player Detail"
    end

    def player_news
        @title = "Player News"
    end

    def headlines
        @title = "Headlines"
    end

    def transactions_contracts
        @title = "Transactions & Contracts"
    end

    def depth_charts
        @title = "Depth Charts"
    end

    def featured_articles
        @title = "Featured Articles"
    end

    def privacy
        @title = "Privacy Policy"
    end

    def terms_conditions
        @title = "Terms & Conditions"
    end

    def rules
        @title = "Rules of the Game"
    end

    def contact
        @title = "Contact Us"
    end
end
