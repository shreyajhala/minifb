MiniFb::Application.routes.draw do
  get "users/show"
  get "static_pages/home"
  get "static_pages/help"
  devise_for :users
  root 'home#index'
  resources :users, :only => [:show] do
    resources :follows, :only => [:create, :destroy, :show]
  end

  resources :users, :only => [:show] do
    resources :albums, :only => [:show, :create, :destroy, :index, :new] do
      resources :photos, :only => [:show, :create, :destroy, :index, :new]
    end
  end

  resources :albums
  
  match '/photos/:album_id', to: 'photos#create', via: 'post', as:'addphoto'
  match '/facebook/albums/:user_id', to: 'albums#show', via: 'get', as: 'fbalbums' 
  match 'auth/failure', to: redirect('/'), via: 'get'
  match 'signout', to: 'mysessions#destroy', via: 'delete'
  match 'auth/:provider/callback', to: 'mysessions#create', via: 'get'
  match '/users/:username-:slug', to: 'users#show', via: 'get'
  devise_scope :user do
    match '/login', to: 'devise/sessions#new', via: 'get'
    match '/login', to: 'devise/sessions#create', via: 'post'
    match '/register', to: 'devise/registrations#new', via: 'get'
    match '/logout', to: 'devise/sessions#destroy', via: 'delete'
  end

  #match '/register' to: 'users#sign_up'
  #match '/login' to: 'users#sign_in'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end