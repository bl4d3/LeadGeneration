LeadGeneration::Application.routes.draw do
  resources :questions do
    get :frontend_question, :controller => :frontends, :on => :member
  end

  resources :contacts

  resources :posts

  resources :arguments

  resources :needs

  resources :estimates

  devise_for :users

  resources :positions

  resources :places

  resources :containers do
  	collection do
  		get 'order'
  	end
  end

  resources :services

  resources :categories do 
    resources :companies do
      # frontend view for companies associated at one category
      get :category_frontend, :controller => :frontends, :on => :collection
    end
  end
  

  resources :zones do
    get :autocomplete_city_name, :on => :collection
    get :autocomplete_department_name, :on => :collection
  end

  resources :departments

  resources :cities

  resources :companies do
    get :autocomplete_city_name, :on => :collection
    get :frontend_company, :controller => :frontends, :on => :member
  end
    
  resources :frontends do
    # frontend for company
    get :new_company, :on => :collection
    post :create_company, :on => :collection
    # frontend for estimate
    get :new_estimate, :on => :collection
    post :create_estimate, :on => :collection    
    # blog
    get :blog, :on => :collection
    get :blog_post, :on => :member
    get :blog_argument, :on => :member
    post :create_blog_reply, :on => :collection
    # contact
    post :create_contact, :on => :collection
    # question
    post :create_question, :on => :collection
    post :create_reply, :on => :collection
    # feed
    get :sitemap, :on => :collection
    get :blogfeed, :on => :collection
  end
  
  # show question
  match 'domanda-matrimonio/(:id)' => "frontends#frontend_question", :as => :frontend_question_question
  # show post
  match 'blog-matrimomio/(:id)' => "frontends#blog_post", :as => :blog_post_frontend
  
  
  
  # TODO naming routes...
  match 'nuova-azienda-matrimonio' => "frontends#new_company", :as => :new_company_frontends
  match 'richiedi-preventivo-per-matrimonio' => "frontends#new_estimate", :as => :new_estimate_frontends
  match 'articoli-blog' => "frontends#blog", :as => :blog_frontends
  match 'dettaglio-articolo' => "frontends#blog_argument", :as => :blog_argument_frontends
  
  match 'matrimonio-idee/(:id)' => "frontends#show", :as => :frontend
  
  match 'categorie-preventivi-matrimonio/(:id)' => "frontends#category_frontend", :as => :category_frontend_category_companies
  match 'azienda-settore-matrimonio/(:id)' => "frontends#frontend_company", :as => :frontend_company_company
  
  match 'sitemap.:format' => "frontends#sitemap", :as => :sitemap
  match 'blogfeed.:format' => "frontends#blogfeed", :as => :blog_feed
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "frontends#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
