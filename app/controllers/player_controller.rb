class PlayerController < ApplicationController

  def all
    @persons = Person.all
  end


end
