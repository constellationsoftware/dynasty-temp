require File.expand_path("../../lib/logged_in_constraint", __FILE__)

Dynasty::Application.routes.draw do

    # Player News Research Pages
    match 'research',                 :to => 'research#index', :as => 'research_index', :via => [:get]
    match 'research/team',            :to => 'research#team', :as => 'research_team', :via => [:get]
    match 'research/player',          :to => 'research#player', :as => 'research_player', :via => [:get]
    match 'research/news',            :to => 'research#news', :as => 'research_news', :via => [:get]
    match 'research/transactions',    :to => 'research#transactions', :as => 'research_transactions', :via => [:get]
    match 'research/contracts',       :to => 'research#contracts', :as => 'research_contracts', :via => [:get]
    match 'research/depth_charts',    :to => 'research#depth_charts', :as => 'research_team', :via => [:get]
    match 'research/players' => 'research#players', :via => [ :get, :post ]

    # Team Financials
    match 'financials',               :to => 'teams#financials', :as => 'team_financials', :via => [:get]

    # Authorize.net stuff

    match '/payments/purchase_dynasty_dollars', :to => 'payments#purchase_dynasty_dollars', :as => 'payments_purchase_dynasty_dollars', :via => [:get]
    match '/payments/dynasty_dollars_receipt', :to => 'payments#dynasty_dollars_receipt', :as => 'payments_dynasty_dollars_receipt', :via => [:get]
    match '/payments/payment', :to => 'payments#payment', :as => 'payments_payment', :via => [:get]
    match '/payments/relay_response', :to => 'payments#relay_response', :as => 'payments_relay_response', :via => [:post]
    match '/payments/receipt', :to => 'payments#receipt', :as => 'payments_receipt', :via => [:get]

    match '/order', :to => 'users#order', :as => 'order'

    if Rails.env.development?
        mount Users::Mailer::Preview => 'mail_view'
    end
    #mount Resque::Server.new, :at => "/resque"

    # REFACTOR: This is inelegant. I couldn't figure out the magic combination of options for 'devise_for' with as poorly documented as it is, but we should figure it out eventually
    devise_for :users, :skip => [ :sessions, :registrations ], :controllers => {
        :sessions => 'users/sessions',
        :registrations => 'users/registrations',
        :invitations => 'users/invitations'
    }
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

    match '/front_office' => redirect('/front_office/roster')
    match '/front_office/:action', :controller => :front_office, :as => :front_office
    match '/coachs_corner' => redirect('/coachs_corner/game_review')
    match '/coachs_corner/:action', :controller => :coaches_corner, :as => :coaches_corner

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

    resource :picks, :only => :update
    resource :team, :module => :users, :controller => :team, :as => 'my_team', :only => [ :show, :edit ]
    match 'leagues/join' => 'leagues#join'
    resources :leagues, :shallow => true, :except => [ :index, :show, :destroy ] do
        resources :games, :only => :show
    end
    resources :games, :only => :show
    resource :draft, :only => :show do
        post :start
        post :finish
        post :reset
        get :postpone
        post :postpone
        get :autopick
    end

    match 'lineups/:action/:from/with/:to', :via => :post, :controller => :lineups
    #resources :lineups do
    #    get :roster, :on => :collection
    #end

    resource :clock, :controller => :clock, :only => [] do
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

    resources :player_teams, :only => [] do
        get :league_roster, :on => :collection
        get :drop, :on => :member
        get :bid, :on => :member
    end

    resources :person_scores

    resources :trades do
        get 'retract'
        get 'accept'
        get 'reject'
        get 'create'
        member do
            get 'edit'
            get 'retract'
        end
    end

    resources :players, :only => [ :show, :index ] do
        get 'research'
        get 'add'
        post 'add'
        member do
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
            get 'create'
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

    root :to => 'users#home', :constraints => LoggedInConstraint.new(true)
    root :to => 'home#index'
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
