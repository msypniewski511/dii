Rails.application.routes.draw do
  resources :swot_analyses
  resources :pestel_analyses
  # resources :business_ideas
  resources :business_ideas do
    member do
      post 'suggestions', to: 'openai_suggestions#create'
    end
    resources :pestel_analyses
  end
  resources :articles
  resources :brands
  resources :ideas
  get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root 'home#index'
end
