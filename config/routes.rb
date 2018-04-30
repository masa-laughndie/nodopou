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

  get '/search', to: 'searches#search'

  resources :mylists, only: [:create, :destroy] do
    member do
      patch '/active',  to: 'mylists#update_active'
      put   '/active',  to: 'mylists#update_active'
      patch '/check',   to: 'mylists#update_check'
      put   '/check',   to: 'mylists#update_check'
    end
  end

  resources :lists, only: [:show, :create, :destroy]

  resource :password_reset, only: [:new, :create],
                            path_names: { new: '' } do
    collection do
      get :confirm,
          :login
    end
  end

  resource :contact, only: :new,
                     path_names: { new: '' } do
    collection do
      post '/confirm', to: 'contacts#sub_create'
      post '/',        to: 'contacts#create'
      get :confirm,
          :thanks
    end
  end

  resource :setting, only: :update,
                     controller: 'users' do
    get '/',        to: 'users#edit'
    get '/email',   to: 'users#email_edit'
    patch '/email', to: 'users#email_update'
    put '/email',   to: 'users#email_update'
  end

  resources :users, param: :account_id,
                    only: [:show, :destroy],
                    path: '/' do
    member do
      get 'mylist',    to: 'mylists#index',
                       as: 'mylists'
      get 'mylist/:id', to: 'mylists#show',
                        as: 'mylist'
    end
  end

end
