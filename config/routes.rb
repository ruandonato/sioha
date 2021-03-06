Rails.application.routes.draw do
  root 'portal#index'

  resources :users, only: [:new, :create, :show, :edit, :update]
  resources :sessions, only: [:new, :create, :destroy]
  resources :teams, only: [:new, :create, :show, :edit, :update, :index]
  resources :requirements, only: [:new, :create, :show, :edit, :update, :index]
  resources :calendar, only: [:show]

  get '/signin' => 'sessions#new'
  get '/signup' => 'users#new'
  delete '/signout' => 'sessions#destroy'

  # teams controller
  get '/teams/:id/invite' => 'teams#invite'
  get '/invite_member' => 'teams#invite_member'
  get '/accept_invite' => 'teams#accept_invite'
  get '/refuse_invite' => 'teams#refuse_invite'
  get '/myteams' => 'teams#myteams'
  get '/teams/:id/team_requirements' => 'teams#team_requirements'
  get '/teams/:id/wiki' => 'teams#wiki'
  get '/teams/:id/wiki/edit' => 'teams#edit_wiki'

  # invites controller
  get '/invites' => 'invites#index'

  # exception routes
  get '*unmatched_route', :to => 'application#raise_not_found!'

  # requirements controller
  get '/requirements/:id' => 'requirements#show'
  get '/user_story' => 'requirements#edit'

  # calendar controller
  get 'calendar#show' => 'calendar#show'

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
