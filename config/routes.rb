Rails.application.routes.draw do
  resources :funding_plans
  get 'competitors/new'
  get 'competitors/create'
  get 'competitors/update'
  get 'competitors/destroy'
  get 'competitor_analyses/new'
  get 'competitor_analyses/create'
  get 'competitor_analyses/show'
  resources :pswot_analyses, only: [:new, :create, :show]
  resources :assessments, only: [:new, :create, :show]
  resources :entrepreneurial_skills_user_responses
  get '/dashboard', to: 'home#dashboard', as: :user_root
  devise_for :users
  
  resources :business_ideas do
    member do
      post 'suggestions', to: 'openai_suggestions#create'
    end
    resource :business_idea_definition, only: [:new, :create, :edit, :update]
    resource :market_research, only: [:new, :create, :edit, :update, :show] do
      post :generate_ai_field, on: :collection
    end
    resource :pestel_analyses
    resource :swot_analyses
    resource :competitor_analyses, only: [:new, :create, :show] do
      resources :competitors
    end

    resource :competitors do
      member do
        post 'ai_analysis', to: 'competitors#ai_analysis'
      end
    end
    resources :competitors do
      member do
        post 'ai_analysis', to: 'competitors#ai_analysis'
      end
    end
    resource :porters_five_force, only: [:new, :create, :edit, :update, :show] do
      member do
        post :generate_ai_analysis
      end
    end

    resource :business_model_canva, only: [:show, :edit, :update] do
      member do
        post 'generate_ai_suggestion', to: 'business_model_canvas#generate_ai_suggestion'
      end
    end

    resource :strategy_development, only: [:edit, :update] do
      post :generate_ai_section
    end
  end
  resources :business_ideas do
    resource :business_idea_definition, only: [:edit, :update] do
      post :generate_ai_field, on: :collection
    end

  end

  resources :funding_plans do
    member do
      post :generate_ai
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
