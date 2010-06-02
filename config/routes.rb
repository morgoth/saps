Saps::Application.routes.draw do
  resources :players, :except => :show
  resources :comments, :except => [:show, :index, :new]
  resources :posts
  resources :users
  resources :teams
  resources :matches, :only => [:index]
  resources :leagues, :except => :show do
    resources :rounds, :except => [:show]
    resources :matches, :except => [:show, :index]
  end
  resource :user_session, :only => [:new, :create, :destroy]
  resources :galleries, :only => [:index, :show]

  match "signup", :to => "users#new"
  match "login", :to => "user_sessions#new"
  match "logout", :to => "user_sessions#destroy"

  root :to => "posts#index"
end
