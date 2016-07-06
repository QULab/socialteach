  Rails.application.routes.draw do

  resources :friendships

  resources :levels

  resources :activity_statuses

  resources :course_enrollments

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :leaderboards, only: [:show]

  # resources :chapters, only: [:show]

  resources :activities, only: [:show] do
    member do
      post 'complete'
    end
  end

  resources :courses, only: [:show, :index] do
    member do
      get 'curriculum'
    end
  end
  get 'my_courses' => 'courses#index_enrolled', format: [:html]


  # Routes that are only for instructors
  namespace :instructor do
    # index shows all courses the current user can modify
    resources :courses, only: [:edit, :destroy, :update, :new, :create, :show, :index], format: [:html]
    resources :chapters, only: [:edit, :destroy, :update, :new, :create, :show], format: [:html]
    resources :activities, only: [:edit, :destroy, :update, :new, :create, :show], format: [:html] do
      collection do
        post 'markdown'

      end
    end
    get 'chapters/:id/predec' => 'chapters#predec', format: [:js], as: 'chapter_predec'
    get 'chapters/:id/tier' => 'chapters#tier', format: [:js], as: 'chapter_tier'
    get 'activities/:id/predec' => 'activities#predec', format: [:js], as: 'activity_predec'
    get 'activities/:id/tier' => 'activities#tier', format: [:js], as: 'activity_tier'
  end

  get 'users/edit_profile'
  get 'users/show'

  devise_for :users, :controllers => {:registrations => "registrations", omniauth_callbacks: "omniauth_callbacks"}
  resources :users



  namespace :graph do
    get 'courses/:id' => 'courses#show', format: [:json]
    get 'chapters/:id' => 'chapters#show', format: [:json]
  end

  post 'activities/:id/feedback' => 'activities#feedback', format: [:json]
  post 'courses/:id/feedback' => 'courses#feedback', format: [:json]


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

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
