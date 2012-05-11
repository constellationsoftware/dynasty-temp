class DraftObserver < ActiveRecord::Observer
    def after_create(draft)
        draft.schedule! # assume schedule is set since it must pass validation
    end
end



