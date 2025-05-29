Rails.application.routes.draw do
  resources :income_categories
  resources :expense_categories
  resources :expenses
  resources :incomes
  root "home#show"

  resources :users, only: [ :new, :create, :show, :edit, :update ]
  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"
  delete "sign_out", to: "sessions#destroy"

  resources :home, only: [ :show ]
end
