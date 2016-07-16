Rails.application.routes.draw do

  devise_for :users, path: '', controllers: {
    sessions: 'custom_sessions',
    registrations: 'custom_registrations'
  }, path_names: {
    #sign_up: 'registration',
    #sign_out: 'logout',
    #sign_in: 'login'
  }


  #devise_scope :user do
    #authenticated :user do
      #root 'quests#index', as: :authenticated_root
    #end

    #unauthenticated do
      #root 'quests#index', as: :unauthenticated_root
    #end
  #end

  root to: 'static_pages#welcome'

  resources :quests

  patch '/quests/:id/sign', to: 'quests#sign', as: 'sign'
  delete '/quests/:id/unsign', to: 'quests#unsign', as: 'unsign'



end
