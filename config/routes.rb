Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  # For details on the DSL available within this file, see
  # http://guides.rubyonrails.org/routing.html

  resources :pages
  resources :categories

  resource :help_doc, only: [:edit, :update] do
    get 'edit', on: :member, to: 'help_docs#edit'
    patch 'update', on: :member, to: 'help_docs#update'
  end

  resource :home, only: [:edit, :update] do
    get 'edit', on: :member, to: 'home#edit'
    patch 'update', on: :member, to: 'home#update'
  end
end
