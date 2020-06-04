Rails.application.routes.draw do
  resources :tasks do
    member do
      patch :show_info
      patch :upd_done
      patch :upd_description
      patch :create_linked
    end
    collection do
      patch :sort
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :users, controllers: {registrations: 'users/registrations', sessions: 'users/sessions'}
  authenticated :user do
    root to: "tasks#index", as: :authenticated_root
  end

  unauthenticated do
    root 'pages#landing'
  end

  
end
