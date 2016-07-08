Rails.application.routes.draw do
  resources :quests
  devise_for :users
  root 'quests#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  patch '/quests/:id/sign', to: 'quests#sign', as: 'sign'
end
