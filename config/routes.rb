Rails.application.routes.draw do
  resources :homes
  resources :platforms
  resources :songs
  root 'homes#index'
  get '/bot/start' => 'bot#start'
  get '/bot/stop' => 'bot#stop'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
