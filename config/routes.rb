Omei::Application.routes.draw do
  devise_for :employees

  devise_for :users
  root :to => 'home#index'
  match 'home(/:action)' => 'home'
  resources :destinations, :pages, :tour_orders

  resources :tours do
    member do
      get 'order'
      post 'order'
    end
    match 'order' => 'orders#new', :via => :get
    match 'order' => 'orders#edit', :via => :post
    match 'prices' => 'orders#prices'
  end

  namespace :admin do
    match 'destinations/photos' => 'destinations#photos'
  	resources :destinations, :buses, :pages
  	resources :tours do
      collection do
        get 'search'
      end
  		resources :spots
  	end
    resources :schedules do
      collection do
        get 'select', 'search'
        put 'selected'
      end
    end
    resources :user_infos do
      collection do
        get 'select', 'search', 'add_tel'
      end
    end
    resources :orders, :employees, :employee_infos, :agents
    resources :payments, :vouchers, :company_receivables
    resources :telephones, :emails, :addresses
    resources :input_types
  end

  match '/admin', :to => 'admin/home#index', :as => :admin
  match 'barcode/:str' => 'barcode#gen'
  match ':controller/:id/:action', :controller => /admin\/[^\/]+/ 

end
