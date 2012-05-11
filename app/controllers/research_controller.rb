class ResearchController < ApplicationController
    respond_to :html, :json
    caches_page :index
    self.resource_class = Player

    has_scope :research, :type => :boolean, :default => true, :only => :players do |controller, scope|
        scope.joins{[ position, contract, name, points ]}
    end

    has_scope :iColumns do |controller, scope, value|
        # use the column count sent by DataTables to process the column data into a select clause
        cols = (0...value.to_i).collect do |i|
            key = "mDataProp_#{i}"
            controller.params[key] if (controller.params.has_key? key) && controller.params[key] != 'null' && !((/[a-z_]+(?:\.[a-z_]+)*/ =~ controller.params[key]).nil?)
        end
        params = cols.compact.push('id').collect do |col|
            params = controller.sort_param_from_chain(col)
            "#{params[:klass].table_name}.#{params[:attribute]} AS '#{col}'"
        end
        scope.select{ params }
    end

    has_scope :iSortingCols do |controller, scope, value|
        cols = (value.to_i).times.collect do |i|
            col = nil
            key = controller.params["iSortCol_#{i}"]
            if !(/[a-z_]+(?:\.[a-z_]+)*/ =~ key).nil?
                col = key
            elsif !(/\d+/ =~ key).nil?
                col = controller.params["mDataProp_#{key}"]
            end
            "`#{col}` #{controller.params["sSortDir_#{i}"]}" unless col.nil?
        end

        scope.order{ cols }
    end

    def players
        start = params[:iDisplayStart].to_i
        length = params[:iDisplayLength].to_i
        #page = (start.zero? ? 0 : (start / length).floor) + 1
        players = apply_scopes(Player)#.paginate :page => page, :per_page => length
        @total = players.count
        @players = players.limit(length).offset(start)
    end

    def index
        #@players ||= Player.current.research.all


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
end
