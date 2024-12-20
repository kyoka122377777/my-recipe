Rails.application.routes.draw do
  get "oauths/oauth"
  get "oauths/callback"
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

  # Google OAuth のログイン
  get '/auth/google_oauth2/callback', to: 'sessions#create'
  get '/auth/failure', to: redirect('/')

  post "/oauth/callback"
  get '/auth/:provider/callback', to: 'sessions#google_oauth2'
  get '/auth/failure', to: 'sessions#new' # 認証失敗時のリダイレクト



  # その他のルーティング
  get 'home/index', to: 'home#index', as: :home
  get '/confirm_email', to: 'users#confirm_email', as: :confirm_email

  get '/favicon.ico', to: proc { [204, {}, []] }

end

