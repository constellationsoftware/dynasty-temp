class PlayersDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: Player.current.research.count,
        iTotalDisplayRecords: players.total_entries,
        aaData: data
    }
  end
private

  def data
    players.map do |player|
      [
          link_to(player.display_name.last_with_first_initial, "/players/#{player.id}"),
          h(player.position.abbreviation.upcase      ),
          h(player.position.designation              ),
          h(player.real_team.display_name.last_name  ),
          h(player.contract.bye_week                 ),
          h(player.contract.amount                   ),
          h(player.contract.summary                  ),
          h(player.contract.end_year                 ),
          h(player.points.points                     ),
          h(player.points.passing_points             ),
          h(player.points.rushing_points             ),
          h(player.points.defensive_points           ),
          h(player.points.fumbles_points             ),
          h(player.points.scoring_points             ),
          h(player.points_per_dollar                 ),
          h(player.points.games_played               )
      ]
    end
  end

  def players
    @players ||= fetch_players
  end



  def fetch_players
    players = Player.current.research.order("#{sort_column} #{sort_direction}")
    players = players.page(page).per_page(per_page)
    if params[:sSearch].present?
      players = players.where("display_name.last_with_first_initial like :search", search: "%#{params[:sSearch]}%")
    end
    players
  end


  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[display_name.last_with_first_initial]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end

end
