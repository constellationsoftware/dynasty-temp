class Pick < ActiveRecord::Base
  belongs_to :team, :class_name => 'UserTeam'
  belongs_to :player, :class_name => 'Salary'
  has_one :user, :through => :user_team

  belongs_to :draft#, :through => :team#, :inverse_of => :drafts


  

 # requires :association, :user_team, :round, :person
 # locks :association, :round, :person

  #validate :one_person_per_draft, :on => :create

  private
  def one_person_per_draft
    if !round.nil?
      round_ids = Round.where(:draft_id => round.draft.id)
      p = Pick.where('person_id = ? and round_id in (?)', person_id, round_ids)
      errors.add(:person, "is already chosen.") if
        !p.empty?
    end
  end

end
