class DraftObserver < ActiveRecord::Observer
  def after_create(model)
    model.create_pick_records
  end
end
