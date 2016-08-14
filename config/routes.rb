Rails.application.routes.draw do
  root 'rooms#index'

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  devise_scope :user do
    delete :sign_out, to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  resources :rooms, param: :uuid do
    member do
      post 'shorturl'
    end
    resources :room_members do
      collection do
        put 'organize'
        patch 'reset_organize'
      end
    end
    resources :room_comments, only: :create
  end

  resources :groups, param: :uuid
end
