Rails.application.routes.draw do
  root 'rooms#index'
  resources :rooms do
    resources :room_members, only: [:create, :destroy]
  end
end
