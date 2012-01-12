class UserTeamLineupsController < ApplicationController

    def update
        @user_team_lineup = UserTeamLineup.current.find(params[:id])
        @utl = @user_team_lineup


        respond_to do |format|
            if @user_team_lineup.update_attributes(params[:user_team_lineup])
                # reset non starters depth to zero
                @non_starters = PlayerTeamRecord.find_all_by_user_team_id(@user_team_lineup.user_team_id)
                @non_starters.each do |ns|
                    ns.depth = 0
                    ns.save
                end
                # set lineup players depth to one
                @utl.qb.depth = 1
                @utl.qb.save
                @utl.wr1.depth = 1
                @utl.wr1.save
                @utl.wr2.depth = 1
                @utl.wr2.save
                @utl.rb1.depth = 1
                @utl.rb1.save
                @utl.rb2.depth = 1
                @utl.rb2.save
                @utl.te.depth = 1
                @utl.te.save
                @utl.k.depth = 1
                @utl.k.save


                format.html { redirect_to(:back, :notice => 'Lineup was successfully updated.') }
                format.xml { head :ok }
            else
                format.html { render :action => "edit" }
                format.xml { render :xml => @team.errors, :status => :unprocessable_entity }
            end
        end
    end

end
