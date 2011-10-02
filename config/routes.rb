Saps::Application.routes.draw do
  resource :account, :only => [:show, :edit, :update]
  resources :players, :except => :show
  resources :comments, :except => [:show, :index, :new]
  resources :posts
  resources :users, :only => [:index, :new, :create]
  resources :teams
  resources :matches, :only => [:index]
  resources :leagues, :except => :show do
    resources :rounds, :except => [:show]
    resources :matches, :except => [:show, :index]
  end
  resource :user_session, :only => [:new, :create, :destroy]
  resources :galleries, :only => [:index, :show]
  resources :password_resets, :only => [:new, :create, :edit, :update]
  resources :achievements, :except => [:show]

  match "signup", :to => "users#new"
  match "login", :to => "user_sessions#new"
  match "logout", :to => "user_sessions#destroy"

  root :to => "posts#index"
end
