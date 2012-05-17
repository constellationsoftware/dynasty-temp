Dynasty::Application.routes.draw do
  # Namespacing for Nested Controllers


  #namespace :league do
  #    namespace :team do
  #        resources :favorites, :games, :lineups, :roster
  #    end
  #
  #    resources :drafts, :messages, :picks, :players, :teams, :trades, :teams
  #end



  # Player News Research Pages
  match "research",                 :to => 'research#index', :as => 'research_index', :via => [:get]
  match "research/team",            :to => 'research#team', :as => 'research_team', :via => [:get]
  match "research/player",          :to => 'research#player', :as => 'research_player', :via => [:get]
  match "research/news",            :to => 'research#news', :as => 'research_news', :via => [:get]
  match "research/transactions",    :to => 'research#transactions', :as => 'research_transactions', :via => [:get]
  match "research/contracts",       :to => 'research#contracts', :as => 'research_contracts', :via => [:get]
  match "research/depth_charts",    :to => 'research#depth_charts', :as => 'research_team', :via => [:get]

  # Team Financials
  match "financials",               :to => 'teams#financials', :as => 'team_financials', :via => [:get]

  # Authorize.net stuff

  match '/payments/purchase_dynasty_dollars', :to => 'payments#purchase_dynasty_dollars', :as => 'payments_purchase_dynasty_dollars', :via => [:get]
  match '/payments/dynasty_dollars_receipt', :to => 'payments#dynasty_dollars_receipt', :as => 'payments_dynasty_dollars_receipt', :via => [:get]
  match '/payments/payment', :to => 'payments#payment', :as => 'payments_payment', :via => [:get]
  match '/payments/relay_response', :to => 'payments#relay_response', :as => 'payments_relay_response', :via => [:post]
  match '/payments/receipt', :to => 'payments#receipt', :as => 'payments_receipt', :via => [:get]

  if Rails.env.development?
    mount Users::Mailer::Preview => 'mail_view'
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

  match '/front_office' => 'front_office#roster'
  match '/front_office/:action', :controller => :front_office, :as => :front_office
  #match '/front_office_home' => 'front_office#roster', :as => "front_office_home"
  #match '/coaches_corner_home' => 'coaches_corner#game_review', :as => "coaches_corner_home"
  match '/coachs_corner', :controller => :coaches_corner, :action => :game_review
  match '/coachs_corner/:action', :controller => :coaches_corner, :as => 'coaches_corner'
  #match '/coaches_corner/swap/:from_id/with/:to_id', :controller => :coaches_corner, :action => :swap
  #match '/roster' => 'front_office#roster'

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

  resource :team, :module => :users, :controller => :team, :as => 'my_team', :only => [ :show, :edit ]
  resources :leagues, :shallow => true do
    resources :games
  end
  resources :games
  resource :draft do
    post :auth
    post :start
    post :finish
    post :reset
    get :postpone
    post :postpone
    get :autopick
  end

  match 'lineups/:action/:from/with/:to', :via => :post, :controller => :lineups
  resources :lineups do
    get :roster, :on => :collection
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
    get :league_roster, :on => :collection
    get :drop, :on => :member
    get :bid, :on => :member
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  resources :person_scores, :events, :positions, :trades, :users, :person_phases, :display_names,
  :stats, :picks, :players, :persons, :people, :drafts, :lineups

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

  resources :players do
    get 'show'
    get 'research'
    get 'add'
    post 'add'
    member do
      get 'show'
      get 'add'
      post 'add'
    end
  end

  resources :users do
 
    get :index
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

  root :controller => :home, :action => :index
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
