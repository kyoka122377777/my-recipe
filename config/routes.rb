Rails.application.routes.draw do
  get 'home/index'
  # ユーザーの認証にDeviseを使用
  devise_for :users

  # タスクに関するルートを定義
  resources :tasks

  # ヘルスチェックのルートを追加
  get "up" => "rails/health#show", as: :rails_health_check

  root "home#index" # トップページ

  # ホーム画面へのルートを追加
  get 'home', to: 'home#home', as: :home 
end

