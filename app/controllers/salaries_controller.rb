class SalariesController < InheritedResources::Base
  #include Rails::ExtJS::Direct::Controller
  respond_to :html, :json
  has_scope :offense, :type => :boolean, :default => true, :only => :index
  has_scope :by_position, :type => :boolean, :default => true, :only => :index
  has_scope :with_valid, :type => :boolean, :default => false, :only => :index

  def index
    total = end_of_association_chain.count()

    super do |format|
      # parse the sort parameters
      #if params[:sort]
      #  sortObj = ActiveSupport::JSON.decode(params[:sort])
      #  sortStr = sortObj.nil? ? Salary.default_sort : sortObj.collect {|o| o.values.join(' ')}.join(', ')
      #  @salaries.order(sortStr)
      #end

      # hard-code the sort order since it seems we may not need sortable columns for the main view
      @salaries = @salaries.order('rating DESC, contract_amount DESC')
      format.json { render json: { :results => @salaries, :total => total } }
    end
  end

  protected
    def collection
      if params[:page]
        @salaries = end_of_association_chain
          .page(params[:page])
          .per(params[:limit])
      end

      Rails.logger.info current_scopes
    end
end
