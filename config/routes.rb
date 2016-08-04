Rails.application.routes.draw do
  root 'rooms#index'

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
