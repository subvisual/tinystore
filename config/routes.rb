require Rails.root.join('lib/constraints/subdomain_constraint')

Tinystore::Application.routes.draw do
  devise_for :users

  constraints(SubdomainConstraint) do
    root to: 'stores#show', as: :store
    resources :products, only: [:show]

    namespace :manager do
      resources :products, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
        patch :restore
      end
    end

    resources :cart_items, only: [:index, :create, :update, :destroy]

    resource :checkout, only: [:new, :create]
  end

  root to: 'pages#index'
end
