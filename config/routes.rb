Rails.application.routes.draw do
  resources :tasks
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :users, controllers: {registrations: 'users/registrations', sessions: 'users/sessions'}
  authenticated :user do
    root to: "pages#home", as: :authenticated_root
  end

  unauthenticated do
    root 'pages#landing'
  end

  
end
