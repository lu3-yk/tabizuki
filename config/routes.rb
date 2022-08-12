Rails.application.routes.draw do

# ログイン関係
  # URL /user/sign_in ...
  devise_for :user,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  devise_scope :user do
    post 'user/guest_sign_in', to: 'public/sessions#guest_sign_in'
    post 'user/guest_sign_up', to: 'public/registrations#guest_sign_up'
  end

  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  

#会員関係
  scope module: :public do
   root :to =>"homes#top"
    get '/users/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    patch '/users/withdrawal' => 'users#withdrawal', as: 'withdrawal'
   resources :users do
    get 'likes', on: :member
    get :follows, :followers, on: :member
    resource :relationships, only: [:create, :destroy]
   end
   resources :tweets do
     resources :comments,only: [:create, :destroy]
     resource :likes,only:[:create, :destroy]
     get 'search', on: :member
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
