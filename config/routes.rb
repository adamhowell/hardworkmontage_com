# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  draw :accounts
  draw :api
  draw :billing
  draw :turbo_native
  draw :users
  draw :dev if Rails.env.local?

  authenticated :user, lambda { |u| u.admin? } do
    draw :admin
  end

  constraints(Subdomain) do
    get '/', to: 'sessions#new' # assuming 'sessions#new' is your login page
  end

  resources :announcements, only: [:index, :show]

  namespace :action_text do
    resources :embeds, only: [:create], constraints: {id: /[^\/]+/} do
      collection do
        get :patterns
      end
    end
  end

  scope controller: :static do
    get :about
    get :terms
    get :privacy
    get :pricing
    get :jumpstart_pro, path: "jumpstart-pro"
    get :campfire
    get :projects
  end

  match "/404", via: :all, to: "errors#not_found"
  match "/500", via: :all, to: "errors#internal_server_error"

  authenticated :user do
    root to: "dashboard#show", as: :user_root
    # Alternate route to use if logged in users should still see public root
    # get "/dashboard", to: "dashboard#show", as: :user_root
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up", to: "rails/health#show", as: :rails_health_check

  # Public marketing homepage
  root to: "static#index"

  ### CUSTOM ROUTES ###

  ### CONTACT ###
  resources :contacts, except: [:show]
  get '/contacts/success', to: 'contacts#show', as: :contacts_success_path

  resources :articles
  resources :events
  resources :members

  devise_scope :user do
    get '/login_code', to: 'users/sessions#login_code'
    post '/login_code', to: 'users/sessions#login_code_submit'
  end

  ### PAYMENTS ###
  get 'stripe_checkout', to: 'payments#stripe_checkout'
end
