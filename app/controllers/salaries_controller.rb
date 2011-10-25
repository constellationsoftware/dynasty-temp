class SalariesController < InheritedResources::Base
  #include Rails::ExtJS::Direct::Controller
  respond_to :html, :json

  protected
    def collection
      super

      total = Salary.count
      
      # parse the sort parameters
      sortObj = params[:sort] ? ActiveSupport::JSON.decode(params[:sort]) : nil
      sortStr = sortObj.nil? ? Salary.default_sort : sortObj.collect {|o| o.values.join(' ')}.join(', ')
      Rails.logger.info sortStr

      @salaries = end_of_association_chain
        .order(sortStr)
        .page(params[:page])
        .per(params[:limit])
      @salaries = {:results => @salaries, :total => total} if params[:format] === 'json'
    end
end
