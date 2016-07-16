Rails.application.routes.draw do
  root 'rooms#index'

  resources :rooms, param: :uuid do
    member do
      post 'shorturl'
    end
    resources :room_members, only: [:create, :destroy]
  end

end
