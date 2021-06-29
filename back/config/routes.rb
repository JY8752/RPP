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
        get 'users/:id', to: 'users#show', id: /\d+/
        put 'users/clear/:id', to: 'users#stage_clear', id: /\d+/
        get 'users/status/:id', to: 'users#status', id: /\d+/

        # enemies_controller
        get 'enemies/:stage_id', to: 'enemies#show', stage_id: /\d+/
    end
  end
end
