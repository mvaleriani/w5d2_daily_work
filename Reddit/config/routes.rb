Rails.application.routes.draw do
  root to: "subs#index"
  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
  resources :subs do
    resources :posts, only: [:create]
  end
    resources :posts, except: [:create, :index]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
