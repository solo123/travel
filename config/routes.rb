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
    resources :destinations do
      collection do
        get :photos
      end
      member do
        get :create_photoset
      end
    end
  	resources :buses, :pages
  	resources :tours do
      collection do
        get 'search'
      end
  		resources :spots
  	end
    resources :schedules do
      collection do
        get :select, :search, :generate
        put 'selected'
      end
      resources :schedule_assignments do
        resources :bus_seats
        member do
          put :hold_seats
        end
      end
    end
    resources :user_infos do
      collection do
        get 'select', 'search', 'add_tel'
      end
    end
    resources :orders, :employees, :employee_infos
    resources :agents do
      collection do
        get 'add_contact'
      end
    end
    resources :payments, :vouchers, :company_receivables
    resources :telephones, :emails, :addresses
    resources :input_types, :tour_types, :positions
  end

  match '/admin', :to => 'admin/home#index', :as => :admin
  match 'barcode/:str' => 'barcode#gen'
  match ':controller/:id/:action', :controller => /admin\/[^\/]+/ 

end
