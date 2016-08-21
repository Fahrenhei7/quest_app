Rails.application.routes.draw do


  scope module: 'web' do

    devise_scope :user do

      authenticated :user do
        root 'quests/quests#index', as: :authenticated_root
      end

      unauthenticated do
        root 'static_pages#welcome', as: :unauthenticated_root
      end

      devise_for :users, path: '', controllers: {
        sessions: 'custom_sessions',
        registrations: 'custom_registrations',
        confirmations: 'devise/confirmations'
      }, path_names: {
        sign_up: 'registration',
        sign_out: 'logout',
        sign_in: 'login'
      }


      scope module: 'quests' do
        resources :quests do
          resources :missions, shallow: true do
            resources :suggestions, shallow: true
          end
        end
        get '/manage_quests', to: 'quests#manage_quests'
        post 'missions/:id/check_key', to: 'missions#check_key', as: 'check_key'

        post '/quests/:id/sign', to: 'quests#sign', as: 'sign'
        delete '/quests/:id/unsign', to: 'quests#unsign', as: 'unsign'
      end

    end

  end
end


