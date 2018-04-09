Rails.application.routes.draw do

  root 'statics#home'

  get '/help',    to: 'statics#help'
  get '/terms',   to: 'statics#terms'
  get '/privacy', to: 'statics#privacy'
  get '/about',   to: 'statics#about'

  get  '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  resources :users, param: :account_id,
                    only: [:show, :destroy],
                    path: '/'

end
