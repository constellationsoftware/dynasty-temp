class DraftablePlayersController < ApplicationController
  def index
    @draftable = DraftablePlayer.limit(500)
    data = {}
    data[:results] = [@draftable]

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: data }
    end
  end

  # POST /draftable_players
  # POST /draftable_players.json
  def create
    @draft = DraftablePlayer.new(params[:draftable_player])

    respond_to do |format|
      if @draftable_player.save
        format.html { redirect_to @draftable_player, notice: 'DraftablePlayer was successfully created.' }
        format.json { render json: @draftable_player, status: :created, location: @draftable_player }
      else
        format.html { render action: "new" }
        format.json { render json: @draftable_player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /draftable_players/1
  # PUT /draftable_players/1.json
  def update
    @draft = DraftablePlayer.find(params[:id])

    respond_to do |format|
      if @draft.update_attributes(params[:draftable_player])
        format.html { redirect_to @draft, notice: 'DraftablePlayer was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @draftable_player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /draftable_players/1
  # DELETE /draftable_players/1.json
  def destroy
    @draftable_player = DraftablePlayer.find(params[:id])
    @draftable_player.destroy

    respond_to do |format|
      format.html { redirect_to draftable_players_url }
      format.json { head :ok }
    end
  end
end


