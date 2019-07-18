Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  
#中間テーブル先のフォロー中のユーザ、フォローされているユーザ一覧表示ページのためのルーティング  
#中間テーブル先のお気に入り中のfavorite一覧表示ページのためのルーティング  
  resources :users, only: [:index, :show, :new, :create] do
    member do
      get :followings
      get :followers
      get :likes
    end
  end
 
  
  resources :microposts, only: [:create, :destroy]
  
#ログインユーザがユーザをフォロー／アンフォローできるようにするルーティング
  resources :relationships, only: [:create, :destroy]

#ログインユーザがmicropostをfavorite／unfavoriteできるようにするルーティング
  resources :favorites, only: [:create, :destroy]
  
  
end
