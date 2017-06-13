Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'auth/wunderlist/callback', to: 'sessions#wunderlist'
  get 'auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  post 'sessions/subscribe', to: 'sessions#subscribe'
  root "sections#index"
  get '/sections/created',to: 'sections#created', as: "created_sections"
  get '/sections/:id/modify',to: 'sections#modify', as: "modify_section"
  get '/sections/assigned',to: 'sections#assigned', as: "assigned_sections"
  resources :sections
  post 'sections/:id/assign', to: 'sections#assign', as: "assign_section"
  resources :modifications
  resources :reviews
  resources :notifications
end
