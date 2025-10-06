# config/routes.rb
Rails.application.routes.draw do
  get "up" => "rails/health#show"

  root "home#show"

  resource  :about,    only: :show
  resources :faqs,     only: :index

  resources :services, only: :index do
    member do
      get :detail
      get "detail/close", action: :detail_close, as: :detail_close
    end
  end

  # Contact routes
  get "/contact", to: "contacts_form#new"
  post "/contact", to: "contacts_form#create"
end
