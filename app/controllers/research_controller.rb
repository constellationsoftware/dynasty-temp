#require 'datatable_mashaller'
class ResearchController < ApplicationController
    respond_to :html, :json
    caches_page :index
    self.resource_class = Player
    #include DatatableMarshaller, :only => :players
    before_filter :process_datatable_params, :only => :players

    has_scope :research, :type => :boolean, :default => true, :only => :players do |controller, scope|
        scope.joins{[ position, contract, name, points, real_team.display_name ]}
    end

    def players
        #page = (start.zero? ? 0 : (start / length).floor) + 1
        players = apply_scopes(Player)#.paginate :page => page, :per_page => length
        @total = players.count
        players = players.offset(params[:start]) if params.has_key? 'start'
        players = players.limit(params[:length]) if params.has_key? 'length'
        @players = players
    end

    def index
        @positions = Position.select{[ id, abbreviation ]}
            .where{ abbreviation !~ '%flex%' }
            .collect{ |p| [ p['abbreviation'].upcase, p['abbreviation'] ] }
        # apply search filters
=begin
        columns = params[:sColumns].split ','
        (0...params[:iColumns].to_i).each do |i|
            value = params["sSearch_#{i}"]
            unless value === ''
                players = filter_resource players.scoped, columns[i], value
            end
        end
=end
        @teams = SportsDb::Team.nfl.current.joins{ display_name }
            .select{[ id, display_name.abbreviation ]}
            .order{ display_name.abbreviation }
            .collect{ |t| [ t['abbreviation'], t['abbreviation'] ] }
    end


    def team
    end

    def player
        @player ||= Player(params[:id])
    end


    def news
    end

    def transactions
    end

    def contracts
    end

    def depth_charts
    end

    # Hash.new{ |h,k| h[k] = Hash.new &h.default_proc }
    def factor(keypath)
        arr = keypath.split('.').map{ |v| v.to_sym }
        val ||= arr.pop
        arr.reverse.inject(val) do |rv, e|
            rv = { e => rv }
        end
    end

    protected
        def process_datatable_params
            params[:request_id] = params.delete(:sEcho).to_i
            params[:start] = params.delete(:iDisplayStart).to_i
            params[:length] = params.delete(:iDisplayLength).to_i
            params.delete :sSearch
            params.delete :bRegex

            columnNames = (params.delete :sColumns).split(',')
            columns = []
            sorters = []
            filters = []
            (0...params.delete(:iColumns).to_i).each do |i|
                property = params.delete("mDataProp_#{i}") unless params["mDataProp_#{i}"] === 'null'
                columns << { :name => columnNames[i], :property => property }
                #columns << property unless property.nil?
                filterValue = params.delete("sSearch_#{i}")
                filters << {
                    :property => columnNames[i],
                    :value => filterValue
                } unless filterValue === ''

                params.delete("bSearchable_#{i}")
                params.delete("bSortable_#{i}")
                params.delete("bRegex_#{i}")
            end

            (0...params.delete(:iSortingCols).to_i).each do |i|
                # assemble sorters
                sorters << {
                    :property => params.delete("iSortCol_#{i}"),
                    :direction => params.delete("sSortDir_#{i}")
                }
            end

            params[:columns] = columns.to_json
            params[:filters] = filters.to_json
            params[:sorters] = sorters.to_json
        end
end
