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
  post "users/:id/resend_confirmation", to: "users#resend_confirmation", as: :resend_confirmation_user

  resources :password_resets, only: [ :new, :create ], path_names: { new: "" }
  get "password_resets/edit", to: "password_resets#edit", as: :edit_password_reset
  patch "password_resets",     to: "password_resets#update", as: :password_reset

  resources :home, only: [ :show, :index ]
end
