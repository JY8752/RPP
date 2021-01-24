Rails.application.routes.draw do
  scope :api do
    scope :v1 do
        # root パス
        root 'users#index'

        # sessions_controller
        post 'signin', to: 'sessions#sign_in'
        delete 'signout', to: 'sessions#sign_out'

        # users_controller
        resources :users
    end
  end
end
