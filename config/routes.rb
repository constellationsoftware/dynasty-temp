Dynasty::Application.routes.draw do
    resources :schedules

    resources :photos

    resources :dynasty_player_contracts


    devise_for :users do
        get "/users/sign_out" => "devise/sessions#destroy", :as => :destroy_user_session
    end

    scope :league, :module => 'league', :constraints => SubdomainConstraint do
        resource :draft, :defaults => {:format => 'html'} do
            member do
                defaults :format => 'text' do
                    post :auth
                    post :start
                    get :start
                    post :reset
                    get :reset
                    get :finish
                end
            end
            defaults :format => 'json' do
                resources :picks do
                    member do
                        get :test_update
                    end
                end
                resources :teams do
                    get :balance
                end
                resource :team do
                    member do
                        get :autopick
                    end
                end
                resources :players
            end
        end
    end

    resources :teams do
        member do
            get :manage
        end
    end


    # The priority is based upon order of creation:
    # first created -> highest priority.

    resources :person_scores, :events, :positions, :trades,
              :user_teams, :user_team_person, :users, :person_phases, :display_names,
              :stats, :fix, :picks, :salaries, :players,
              :persons, :people, :drafts, :leagues, :admin_dashboard, :clock, :clocks, :user_team_lineups, :player_team_records

    resources :teams do
        resources :display_name, :person_phases
    end

    resources :trades do
        get 'retract'
        get 'accept'
        get 'reject'
        member do
            get 'edit'
            get 'retract'
        end
    end

    resources :players do
        get 'show'
        get 'add'
        post 'add'
        member do
            get 'show'
            get 'add'
            post 'add'
        end
    end

    resources :clock do
        get 'show'
        get 'next_week'
        get 'reset'
        get 'present'

    end

    resources :users do
        get :home
    end

    resources :player_team_records do
        member do
            put :start
            put :bench
            get 'drop'
            get 'add'
            get 'bid'
            post 'bid'
            get 'resolve'
            post 'resolve'
        end
    end

    resources :user_team_lineups do
        post 'update'
        get 'update'
    end
    resources :persons do
        resources :display_name
    end

    resources :user_teams do
        member do
            get 'manage'
            get 'roster'
        end

    end


    # Sample of regular route:
    #   match 'products/:id' => 'catalog#view'
    # Keep in mind you can assign values other than :controller and :action

    # Sample of named route:
    #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
    # This route can be invoked with purchase_url(:id => product.id)

    # Sample resource route (maps HTTP verbs to controller actions automatically):
    #   resources :products

    # Sample resource route with options:
    #   resources :products do
    #     member do
    #       get 'short'
    #       post 'toggle'
    #     end
    #
    #     collection do
    #       get 'sold'
    #     end
    #   end

    # Sample resource route with sub-resources:
    #   resources :products do
    #     resources :comments, :sales
    #     resource :seller
    #   end

    # Sample resource route with more complex sub-resources
    #   resources :products do
    #     resources :comments
    #     resources :sales do
    #       get 'recent', :on => :collection
    #     end
    #   end

    # Sample resource route within a namespace:
    #   namespace :admin do
    #     # Directs /admin/products/* to Admin::ProductsController
    #     # (app/controllers/admin/products_controller.rb)
    #     resources :products
    #   end

    # You can have the root of your site routed with "root"
    # just remember to delete public/index.html.
    root :to => "users#home"

    # See how all your routes lay out with "rake routes"

    # This is a legacy wild controller route that's not recommended for RESTful applications.
    # Note: This route will make all actions in every controller accessible via GET requests.
    # match ':controller(/:action(/:id(.:format)))'
end
