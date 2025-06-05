Rails.application.routes.draw do
  resources :budgets
  resources :income_categories
  resources :expense_categories
  resources :expenses
  resources :incomes
  root "home#show"

  resources :users, only: [ :new, :create, :show, :edit, :update ]
  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"
  delete "sign_out", to: "sessions#destroy"
  get "confirm_email", to: "users#confirm_email"

  resources :home, only: [ :show ]
end
