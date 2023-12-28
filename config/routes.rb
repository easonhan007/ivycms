Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get '/:locale' => 'home#index'
  # Defines the root path route ("/")
  root "home#index"
  scope "(:locale)", locale: /en|zh-CN/ do
    get '/', to: 'home#index'
    get '/search', to: 'home#search', as: 'home_search'
    get '/categories', to: 'home#categories'
    get '/category/:category', to: 'home#category', as: 'home_category'
    get '/product/:product', to: 'home#product', as: 'home_product'
    get '/products', to: 'home#products', as: 'home_products'
    get '/about', to: 'home#about', as: 'about_us'
    get '/news', to: 'home#news', as: 'news'
    get '/downloads', to: 'home#downloads', as: 'home_downloads'
    get '/contact', to: 'home#contact', as: 'contact'
    get '/blog', to: 'home#posts', as: 'home_posts'
    get '/post/:post', to: 'home#post', as: 'home_post'
    post '/create_inquiry', to: 'home#inquiry', as: 'home_inquiry'

    scope :admin do
      get '/', to: 'admin#index'
      get 'users/index', as: 'users'

      resources :settings, only: [:edit, :update, :index]
      resources :posts
      resources :download_files
      resources :banners
      resources :inquiries
      resources :post_categories
      resources :navigations

      resources :images do
        collection do
          post 'create_from_product'
        end
        
        member do
          delete 'remove_from_product'
        end
      end

      resources :products do
        collection do
          get 'add_an_image'
        end
      end

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
