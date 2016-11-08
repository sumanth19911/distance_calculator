Rails.application.routes.draw do
  resources :locations
  root   'locations#difference'
  get    '/calculate_difference', to: 'locations#calucate_difference'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
