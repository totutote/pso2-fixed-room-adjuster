Rails.application.routes.draw do
  root 'rooms#index'
  resources :rooms do
    resources :room_members, only: [:create, :destroy]
    resources :room_members do
      member do
        put 'organize'
        delete 'reset_organize'
      end
    end
  end
end
