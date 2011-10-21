class BackupPick < ActiveRecord::Base
  belongs_to :user
  belongs_to :person

  #requires :association, :user, :person
  #requires :attribute, :preference

  #locks :association, :user

  validates_uniqueness_of :person_id, :scope => :user_id
  validates_numericality_of :preference
end
