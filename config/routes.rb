Rails.application.routes.draw do
  root 'rooms#index'
  resources :rooms do
    member do
      post 'shorturl'
    end
    resources :room_members, only: [:create, :destroy]
  end
end
