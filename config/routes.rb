ActionController::Routing::Routes.draw do |map|
  map.resources :players, :except => :show
  map.resources :comments, :except => [:show, :index, :new]
  map.resources :posts
  map.resources :users
  map.resource :session, :only => [:new, :create, :destroy]
  map.resources :teams
  map.resources :leagues, :has_many => [:rounds, :matches]

  map.signup '/signup', :controller => 'users', :action => 'new'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.gallery '/gallery', :controller => 'galleries', :action => 'albums'

  map.root :controller => 'Posts'

  map.connect ':locale/:controller/:action/:id'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
