Rails.application.routes.draw do

  root 'statics#home'

  get '/help',    to: 'statics#help'
  get '/terms',   to: 'statics#terms'
  get '/privacy', to: 'statics#privacy'
  get '/about',   to: 'statics#about'

  get  '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/auth/:provider/callback', to: 'sessions#omniauth_create'

  resources :lists, only: :none do
    member do
      patch '/active',  to: 'lists#update_active'
      put   '/active',  to: 'lists#update_active'
    end
  end

  resource :setting, only: :none do
    get '/',        to: 'users#edit'
    patch '/',      to: 'users#update'
    put '/',        to: 'users#update'
    get '/email',   to: 'users#email_edit'
    patch '/email', to: 'users#email_update'
    put '/email',   to: 'users#email_update'
  end

  resources :users, param: :account_id,
                    only: [:show, :destroy],
                    path: '/' do

    member do
      resources :lists, except: :new
    end
  end

end
