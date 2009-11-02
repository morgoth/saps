ActionController::Routing::Routes.draw do |map|
  map.resources :players, :except => :show
  map.resources :comments, :except => [:show, :index, :new]
  map.resources :posts
  map.resources :users
  map.resources :teams
  map.resources :matches, :only => [:index]
  map.resources :leagues, :except => :show do |league|
    league.resources :rounds, :except => [:show]
    league.resources :matches, :except => [:show, :index]
  end
  map.resource :user_session, :only => [:new, :create, :destroy]
  map.resources :galleries, :only => [:index, :show]

  map.signup '/signup', :controller => 'users', :action => 'new'
  map.login '/login', :controller => 'user_sessions', :action => 'new'
  map.logout '/logout', :controller => 'user_sessions', :action => 'destroy'

  map.root :controller => 'Posts'
end
