Dynasty::Application.routes.draw do
    # Authorize.net stuff

    match '/payments/purchase_dynasty_dollars', :to => 'payments#purchase_dynasty_dollars', :as => 'payments_purchase_dynasty_dollars', :via => [:get]

    match '/payments/dynasty_dollars_receipt', :to => 'payments#dynasty_dollars_receipt', :as => 'payments_dynasty_dollars_receipt', :via => [:get]

    match '/payments/payment', :to => 'payments#payment', :as => 'payments_payment', :via => [:get]

    match '/payments/relay_response', :to => 'payments#relay_response', :as => 'payments_relay_response', :via => [:post]
    match '/payments/receipt', :to => 'payments#receipt', :as => 'payments_receipt', :via => [:get]


    if Rails.env.development?
        mount UserMailer::Preview => 'mail_view'
    end

    resources :messages, :schedules, :photos, :dynasty_player_contracts

    # REFACTOR: This is inelegant. I couldn't figure out the magic combination of options for 'devise_for' with as poorly documented as it is, but we should figure it out eventually
    devise_for :users, :skip => [ :sessions, :registrations ], :controllers => { :sessions => 'users/sessions', :registrations => 'users/registrations' }
    as :user do
        #root :to => 'users#home'
        get     '/login' => 'users/sessions#new', :as => :new_user_session
        post    '/login' => 'users/sessions#create', :as => :user_session
        delete  '/logout' => 'users/sessions#destroy', :as => :destroy_user_session
        get     '/logout' => 'users/sessions#destroy', :as => :destroy_user_session

        post    '/profile' => 'users/registrations#create', :as => :create_user_registration
        get     '/register' => 'users/registrations#new', :as => :new_user_registration
        get     '/profile' => 'users/registrations#edit', :as => :user_registration
        put     '/profile' => 'users/registrations#update', :as => :edit_user_registration
    end

    resource :mockups do
        get :index
        get :login

        get :new_team

        get :player_research
        get :player_detail

        get :signup
        get :signup_2
        get :signup_3
        get :signup_4
        get :signup_5
        get :create_team


        get :team_marketplace
        get :sell_team
        get :purchase_team
        get :confirm_team_purchase
        get :confirm_team_sale

        get :league_review

        get :user_control_panel
        get :team_control_panel

        get :player_news
        get :headlines
        get :transactions_contracts
        get :depth_charts
        get :featured_articles

        get :rules
        get :terms_conditions
        get :privacy
        get :contact
    end

    match '/manage' => 'users/team#show', :as => 'manage_team'
    match '/front_office/:action', :controller => :front_office, :as => :front_office
    match '/coaches_corner/:action', :controller => :coaches_corner, :as => :coaches_corner
    match '/koaches_korner/:action', :controller => :coaches_corner, :as => :coaches_corner

    resource :team, :module => :users, :controller => :team, :as => 'my_team', :only => [ :show, :edit ]
    resources :leagues, :shallow => true do
        resources :games do
            get :review, :on => :collection
        end
    end

    scope :module => :league, :constraints => SubdomainConstraint do
        resources :auto_picks do
            collection do
                post :sort
            end
        end
        resource :draft, :defaults => {:format => 'html'} do
            member do
                defaults :format => 'text' do
                    post :auth
                    post :start
                    get :start
                    post :reset
                    get :reset
                    get :finish

                    post :send_message
                end
            end

            defaults :format => 'json' do
                resources :picks do
                    get :test_update, :on => :member
                end
                resources :teams
=begin
                resource :team do
                    get :autopick, :on => :member
                end
=end
                resources :players
            end
        end

        # The team in this case is always the user's team for this league
=begin
        resource :team, :controller => :team, :module => :team do
            defaults :format => 'json' do
                resources :favorites
                resources :roster do
                    get :bench, :on => :collection, :action => :index, :defaults => { :bench => 0 }
                end
                resources :lineup
                resources :games
                resource :balance
            end
        end
=end

        resources :trades
    end

    resource :clock, :controller => :clock, :except => [ :index, :delete ] do
        member do
            get :next_week
            get :reset
        end
    end

    resources :teams do
        member do
            get :account
            get :manage
            get :roster
        end
    end

    resources :player_teams do
        member do
            get :drop
        end
    end

    # The priority is based upon order of creation:
    # first created -> highest priority.

    resources :person_scores, :events, :positions, :trades, :users, :person_phases, :display_names,
              :stats, :picks, :players, :persons, :people, :drafts, :lineups

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

    resources :users do
        get :home
    end

    resources :player_teams do
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

    resources :persons do
        resources :display_name
    end

    root :controller => :users, :action => :home
    ActiveAdmin.routes(self)

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

    # See how all your routes lay out with "rake routes"

    # This is a legacy wild controller route that's not recommended for RESTful applications.
    # Note: This route will make all actions in every controller accessible via GET requests.
    # match ':controller(/:action(/:id(.:format)))'
end
