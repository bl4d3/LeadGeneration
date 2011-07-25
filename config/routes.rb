LeadGeneration::Application.routes.draw do
  resources :delivers

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
    get :aggregator_show, :on => :collection
    get :search_on_map, :on => :collection
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
    # send queued emails
    get :send_mail, :on => :collection
    # public geocode
    get :public_geocode, :on => :collection
  end
  
  # show question
  match 'domanda-matrimonio/(:id)' => "frontends#frontend_question", :as => :frontend_question_question
  # show post
  match 'blog-matrimomio/(:id)' => "frontends#blog_post", :as => :blog_post_frontend
  match 'blog/(:id)' => "frontends#blog_argument", :as => :blog_argument_frontend
  
  match 'q' => "frontends#send_mail"
  
  
  # named routes
  match 'nuova-azienda-matrimonio' => "frontends#new_company", :as => :new_company_frontends
  match 'richiedi-preventivi-per-matrimonio' => "frontends#new_estimate", :as => :new_estimate_frontends
  match 'articoli-blog' => "frontends#blog", :as => :blog_frontends
  match 'dettaglio-articolo' => "frontends#blog_argument", :as => :blog_argument_frontends
  
  match 'organizzare-matrimonio/(:id)' => "frontends#show", :as => :frontend
  
  match 'categorie-preventivi-matrimonio/(:id)' => "frontends#category_frontend", :as => :category_frontend_category_companies
  match 'azienda-settore-matrimonio/(:id)' => "frontends#frontend_company", :as => :frontend_company_company
  
  match 'sitemap.:format' => "frontends#sitemap", :as => :sitemap
  match 'blogfeed.:format' => "frontends#blogfeed", :as => :blog_feed
 
  root :to => "frontends#index"
end
