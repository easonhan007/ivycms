Rails.application.routes.draw do
  resources :products
  devise_for :users, controllers: { registrations: "registrations" }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get '/:locale' => 'home#index'
  # Defines the root path route ("/")
  root "home#index"
  scope "(:locale)", locale: /en|zh-CN/ do
    get 'home/index'

    scope :admin do
      get 'users/index', as: 'users'

      resources :settings, only: [:edit, :update]
      resources :posts
      resources :download_files
      resources :banners

      resources :product_categories do
        member do
          get 'new_a_child'
          get 'show_modal'
          post 'toggle_status'
        end
      end

      resources :friend_links do
        member do 
          get 'show_modal'
        end 
      end

    end #admin

  end

end
