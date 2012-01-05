Dynasty::Application.routes.draw do
  resources :photos

  resources :dynasty_player_contracts

  ActiveAdmin.routes(self)
  devise_for :users

  scope :league, :module => 'league', :constraints => SubdomainConstraint do
    resource :draft, :defaults => { :format => 'html' } do
      member do
        post 'auth'
        post 'start', :format => 'text'
        post 'pick', :format => 'text'
        post 'reset', :format => 'text'
      end
      defaults :format => 'json' do
        resources :picks
        resources :teams do
          get 'balance'
        end
        resources :players do
          get 'search', :on => :collection
        end
      end
    end


    resource :trades do
      member do
        get 'edit'

      end
    end


  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  resources :person_scores, :events, :positions, :trades,
            :user_teams, :user_team_person, :users, :person_phases, :display_names,
            :stats, :fix, :picks, :salaries,
            :persons, :people, :drafts, :leagues, :admin_dashboard, :clock, :clocks

  resources :teams do
    resources :display_name, :person_phases
  end

  resources :clock do
    get 'show'
    get 'next_week'
    get 'reset'
    get 'present'
  end

  resources :users do
    get 'home'
  end

  resources :persons do
    resources :display_name
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
  root :to => "users#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
