Rails.application.routes.draw do
  resources :pswot_analyses, only: [:new, :create, :show]
  resources :assessments, only: [:new, :create, :show]
  resources :entrepreneurial_skills_user_responses
  get '/dashboard', to: 'home#dashboard', as: :user_root
  devise_for :users
  
  resources :business_ideas do
    member do
      post 'suggestions', to: 'openai_suggestions#create'
    end
    resource :pestel_analyses
    resource :swot_analyses
    resource :porters_five_force, only: [:new, :create, :edit, :update, :show] do
      member do
        post :generate_ai_analysis
      end
    end
  end
  resources :articles
  resources :brands
  resources :ideas
  get 'home/index'
  get 'home/personal'

  namespace :api do
    namespace :v1 do
      resources :business_ideas do
        post 'suggestions', to: 'openai_suggestions#create'
        resource :pestel_analyses
        resource :swot_analyses
      end
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root 'home#index'
end
