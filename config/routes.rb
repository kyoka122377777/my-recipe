Rails.application.routes.draw do
  # トップページのルーティング
  root 'welcome#index'

  # ユーザーセッションのルーティング
  get '/login', to: 'sessions#new', as: :login
  post '/login', to: 'sessions#create', as: :create_session
  delete '/logout', to: 'users#destroy', as: :logout


  resources :users, only: [:new, :create, :show, :edit, :update]
  get '/menu', to: 'menu#index', as: :menu
  resource :account, only: [:show, :edit, :update], controller: 'users'
  resources :recipes, only: [:new, :create, :show, :index, :edit, :update, :destroy] do
    collection do
      get :search
    end
  end
  


  # その他のルーティング
  get 'home/index', to: 'home#index', as: :home
  get '/confirm_email', to: 'users#confirm_email', as: :confirm_email
end

