Rails.application.routes.draw do
  root "users#login"

  post "/login", to: "users#login"
  post "/posts/import", to: "posts#import_csv"
  resources :users
  resources :posts
end
