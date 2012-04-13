module CoachesCornerHelper
    def game_review_tab_class(won, active)
        classes = []
        unless won.nil?
            classes << (won ? 'won' : 'lost')
        end
        classes << 'active' if active
        classes
    end
end
