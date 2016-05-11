Rails.application.routes.draw do

  root 'pages#index'
  get 'charts' => 'pages#charts'
  get 'tables' => 'pages#tables'
  post 'rollup' => 'pages#rollup'
  post 'drilldown' => 'pages#drilldown'
  post 'slice' => 'pages#slice'

  post 'add_dimension' => 'pages#add_dimension'
  post 'remove_dimension' => 'pages#remove_dimension'

end
