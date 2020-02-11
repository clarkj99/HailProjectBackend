Rails.application.routes.draw do
  resources :reports
  get "/dates", to: "reports#dates"
end
