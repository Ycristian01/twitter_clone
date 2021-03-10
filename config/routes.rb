Rails.application.routes.draw do
  root "users#index"
  resources :users, except:[:create, :show, :destroy, :edit, :update] do
    resources :tweets
  end

  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  get "/:username", to: "users#show", as: "username"

  post '/users/:id/follow', to: "users#follow", as: "follow_user"
  post '/users/:id/unfollow', to: "users#unfollow", as: "unfollow_user"
end
