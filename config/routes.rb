Rails.application.routes.draw do
  # ユーザーの認証にDeviseを使用
  devise_for :users

  # タスクに関するルートを定義
  resources :tasks

  # ヘルスチェックのルートを追加
  get "up" => "rails/health#show", as: :rails_health_check

  # ルートパスを設定 (タスクのインデックスにリダイレクト)
  root "tasks#index"
end

