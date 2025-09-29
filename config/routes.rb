Rails.application.routes.draw do
  get "up" => "rails/health#show"  # healthcheck
  root "pages#home"

  get "/about",    to: "pages#about"
  get "/services", to: "pages#services"
  get "/services/:id", to: "pages#service_detail", as: :service_detail
  get "/services/:id/close", to: "pages#service_detail_close", as: :close_service_detail
  get "/faqs",     to: "pages#faqs"

  get  "/contact", to: "contacts#new"
  post "/contact", to: "contacts#create"
end
