Rails.application.routes.draw do
  scope :api do
    scope :v1 do
        # root パス
        root 'users#index'

        # sessions_controller
        post 'signin', to: 'sessions#sign_in'
        delete 'signout', to: 'sessions#sign_out'

        # users_controller
        post 'users', to: 'users#create'
        put 'users/:id', to: 'users#update', id: /\d+/
        delete 'users/:id', to: 'users#destroy', id: /\d+/
        get 'users', to: 'users#index'
    end
  end
end
