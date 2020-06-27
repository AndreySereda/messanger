require 'sidekiq/web'

Rails.application.routes.draw do
  get 'pages/home'
  root 'pages#home'
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end


  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

end