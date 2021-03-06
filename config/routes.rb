Rails.application.routes.draw do
  post 'login' => 'sessions#create'

  get 'logout' => 'sessions#destroy'

  resources :quests

  root 'main#index'
  get 'about' => 'main#about'

  post 'users' => 'users#create'

  post 'users/:id/update' => 'users#update'

  post 'quests/location' => 'quests#complete_location'

  post 'quests/:id/remove_user' => 'quests#remove_user'

  post 'quests/:id/add_user' => 'quests#add_user'

  post 'quests/:id/remove_location' => 'quests#remove_location'

  post 'quests/:id/add_location' => 'quests#add_location'

  get 'quests/:id/complete' => 'quests#complete'

  # get 'users/new'
  get 'users/:id/edit' => 'users#edit'

  get 'users/:id', to: 'users#show', as: 'user'

  delete 'user/:id' => 'users#destroy'

  # get 'main/test' => 'main#mapstest'

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
