Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  root "sections#index"
  resources :sections
  post 'sections/:id/assign', to: 'sections#assign', as: "assign_section"
  resources :modifications
end
