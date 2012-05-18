module DatatableMarshaller
    def self.included(base); base.extend(ClassMethods) end

    module ClassMethods
        def inherited(base)
            super(base)
            before_filter :process_datatable_params
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
