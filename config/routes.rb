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

  # Error pages
  %w(404 422 500).each do |code|
    get code, to: "errors#not_found" if code == '404'
    get code, to: "errors#unprocessable" if code == '422'
    get code, to: "errors#internal_error" if code == '500'
  end

  # Contact routes
  get "/contact", to: "contacts_form#new"
  post "/contact", to: "contacts_form#create"

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
