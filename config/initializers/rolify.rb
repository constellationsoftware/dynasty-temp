Rolify.configure do |config|
    # By default ORM adapter is ActiveRecord. uncomment to use mongoid
    # config.use_mongoid

    # Dynamic shortcuts for User class (user.is_admin? like methods). Default is: false
    config.use_dynamic_shortcuts
end

# monkey patch resource_adapter since the query it builds contains double quotes which causes problems
module Rolify
    module Adapter
        class ResourceAdapter < ResourceAdapterBase
            def resources_find(roles_table, relation, role_name)
                resources = relation.joins("INNER JOIN `#{roles_table}` ON `#{roles_table}`.`resource_type` = '#{relation.to_s}'")
                resources = resources.where("#{roles_table}.name = ? AND #{roles_table}.resource_type = ?", role_name, relation.to_s)
                resources
            end
        end
    end
end
