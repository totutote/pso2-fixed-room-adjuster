Rails.application.routes.draw do
  get 'groups/index'

  get 'groups/new'

  get 'groups/create'

  get 'groups/show'

  get 'groups/edit'

  get 'groups/update'

  get 'groups/destroy'

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
  end

  resources :groops, param: :uuid

end
