Rails.application.routes.draw do
  devise_for :admins
  root "pages#home"

  get "/about",    to: "pages#about"
  get "/services", to: "pages#services"
  get "/services/:id", to: "pages#service_detail", as: :service_detail
  get "/faqs",     to: "pages#faqs"

  resources :contact_requests, only: [:new, :create]

  # Friendly path
  get "/contact", to: "contact_requests#new"

  # Admin routes
  namespace :admin do
    root "dashboard#index"
    resources :site_contents
    resources :contact_requests, only: [:index, :show, :destroy]
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  
  # Additional health checks
  get "health" => "health#show"
  get "health/detailed" => "health#detailed"

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
