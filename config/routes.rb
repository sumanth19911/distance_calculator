Rails.application.routes.draw do
  resources :locations
  match '/' => 'locations#difference', via: :get, as: :difference
  match '/closets' => 'locations#closest', via: :get, as: :closest

  get    '/calculate_difference', to: 'locations#calucate_difference'
  get     '/closets' , to: 'locations#closest'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
