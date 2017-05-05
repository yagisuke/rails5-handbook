Rails.application.routes.draw do
  resources :members
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
  get 'view/select_tag'
  get 'view/col_select'
  get 'view/col_select2'
  get 'view/group_select'
  get 'view/group_select2'
  get 'view/dat_select'
  get 'view/col_radio'
  get 'view/fields'
  get 'view/simple_format'
  get 'view/truncate'
  get 'view/excerpt'
  get 'view/highlight'
  get 'view/conc'
  get 'view/sanitize'
  get 'view/format'
  get 'view/number_to'
  get 'view/datetime'
  get 'view/link'
  get 'view/urlfor'
  get 'view/new'
  get 'view/linkif'
  get 'view/current'
  get 'view/mailto'
  get 'view/image_tag'
  get 'view/audio'
  get 'view/video'
  get 'view/path'
  get 'view/capture'
  get 'view/tag'
  get 'view/content_tag'
  get 'view/helper'
  get 'view/helper2'
  get 'view/helper3'
  get 'view/adopt'
  get 'view/provide'
  get 'view/multi'
  get 'view/relation'
  get 'view/download'
  get 'view/quest'
  get 'view/nest'
  get 'view/partial_basic'
  get 'view/partial_param'
  get 'view/partial_col'

  # 第5章
  get 'record/find'
  get 'record/find_by'
  get 'record/find_by2'
  get 'record/where'
  get 'record/where2'
  get 'record/keyword'
  post 'record/ph1'
  get 'record/not(/:id)', to: 'record#not'
  get 'record/where_or'
  get 'record/order'
  get 'record/reorder'
  get 'record/select'
  get 'record/select2'
  get 'record/offset'
  get 'record/page(/:id)', to: 'record#page'
  get 'record/last'
  get 'record/groupby'
  get 'record/groupby2'
  get 'record/havingby'
  get 'record/unscope'
  get 'record/none(/:id)', to: 'record#none'
  get 'record/pluck'
  get 'record/exists'
  get 'record/scope'
  get 'record/publish_rank'
  get 'record/def_scope'
  get 'record/count'
  get 'record/publish_count'
  get 'record/average'
  get 'record/literal_sql'
  get 'record/update_all'
  get 'record/update_all2'
  get 'record/destroy', to: 'record#destroy'
  get 'record/transact'
  get 'record/enum_rec'
  get 'record/get_published'
  get 'record/keywd'
  post 'record/keywd_process'
  get 'record/belongs'
  get 'record/hasmany'
  get 'record/hasone'
  get 'record/has_and_belongs'
  get 'record/has_many_through'
  get 'record/fan_comment'
  get 'record/cache_counter'
  get 'record/book_memorize'
  get 'record/author_memorize'
  get 'record/assoc_join'
end
