Rails.application.routes.draw do

# ログイン関係
  # URL /user/sign_in ...
  devise_for :user,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

#会員関係
  scope module: :public do
   root :to =>"homes#top"
   resources :users do
    # 退会確認画面
    get '/users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    # 論理削除用のルーティング
    patch '/users/:id/withdrawal' => 'users#withdrawal', as: 'withdrawal'
    get "likes", on: :member
    get :follows, :followers, on: :member
    resource :relationships, only: [:create, :destroy]
  end
   resources :tweets do
     resources :comments,only: [:create, :destroy]
     resource :likes,only:[:create, :destroy]
     collection do
       get 'get_prefecture_children', defaults: { format: 'json' }
     end
   end
  end

#管理者関係
  namespace :admin do
    resources :users
  end


end
