class SalariesController < InheritedResources::Base
  #include Rails::ExtJS::Direct::Controller
  respond_to :html, :json
  has_scope :offense, :type => :boolean, :default => true, :only => :index
  has_scope :by_position, :type => :boolean, :default => true, :only => :index

  def index
    total = end_of_association_chain.count()

    super do |format|
      # parse the sort parameters
      sortObj = params[:sort] ? ActiveSupport::JSON.decode(params[:sort]) : nil
      sortStr = sortObj.nil? ? Salary.default_sort : sortObj.collect {|o| o.values.join(' ')}.join(', ')

      format.json { render json: { :results => @salaries.order(sortStr), :total => total } }
    end
  end

  protected
    def collection
      super

      @salaries = end_of_association_chain
        .page(params[:page])
        .per(params[:limit])

      Rails.logger.info current_scopes
    end
end
