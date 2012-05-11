class BaseStat < ActiveRecord::Base
    self.abstract_class = true
    has_one :stat, :as => :stat_repository

    # subclasses should implement this method, which should return the
    # modification to a PersonScore that should happen. By default, it'll return
    # 0.
    def score_modifier
        return 0
    end
end
