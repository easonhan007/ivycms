Rails.application.routes.draw do
  get 'users/index'
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
      resources :settings, only: [:edit, :update]
      get 'users/index', as: 'users'
    end 

  end

end
