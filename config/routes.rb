Rails.application.routes.draw do

  root 'static#home'

  get '/help',    to: 'static#help'
  get '/terms',   to: 'static#terms'
  get '/privacy', to: 'static#privacy'
  get '/about',   to: 'static#about'

end
