# config/routes.rb
Rails.application.routes.draw do
  get "up" => "rails/health#show"

  root "home#show"

  resource  :about,    only: :show
  resources :faqs,     only: :index

  resources :services, only: :index do
    member do
      get :detail
      get "detail/close", action: :close, as: :detail_close
    end
  end

  # ⬇️ Use a symbol for the controller name
  resource :contact, only: [ :new, :create ], controller: :contacts_form
end
