Rails.application.routes.draw do
  resources :fan_comments
  resources :reviews
  resources :authors
  resources :users
  resources :books
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'hello/', to: 'hello#index'
  get 'hello/view/', to: 'hello#view'
  get 'hello/nothing/', to: 'hello#nothing'
  get 'hello/list/', to: 'hello#list'
  get 'hello/app_var/', to: 'hello#app_var'
end
