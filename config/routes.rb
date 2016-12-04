Rails.application.routes.draw do

  get 'proposal/show'

  get 'proposal/new'

  get 'proposal/create'

  get 'user/show'

  get 'user/new'

  get 'tender/show'

  get 'user/create'

  get 'main/index'

  get 'route/index'

  root 'main#index'

  resources :tender, :user, :proposal
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
