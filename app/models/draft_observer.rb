class DraftObserver < ActiveRecord::Observer
  def after_create(model)
    model.number_of_rounds.times do
      model.rounds.create
    end
  end
end
