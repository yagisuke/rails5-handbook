Rails.application.routes.draw do
  resources :fan_comments
  resources :reviews
  resources :authors
  resources :users
  resources :books

  # 第2章
  get 'hello', to: 'hello#index'
  get 'hoge/index', to: 'hello#index'
  get 'hello/view', to: 'hello#view'
  get 'hello/nothing'
  get 'hello/list'
  get 'hello/app_var'

  # 第４章
  get 'view/keyword'
  post 'keyword/search'
  get 'view/form_tag'
  get 'view/form_for'
  get 'view/field'
  get 'view/html5'
  get 'view/select'
  get 'view/col_select'
  get 'view/group_select'
end
