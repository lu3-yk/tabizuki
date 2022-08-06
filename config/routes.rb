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
   get "homes/about"=>"homes#about"
   resources :users
   resources :tweets do
     resources :comments,only: [:create, :destroy]
   end
  end

#管理者関係
  namespace :admin do
    resources :users
  end


end
