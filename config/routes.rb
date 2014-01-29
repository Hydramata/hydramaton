Hydramaton::Application.routes.draw do
  root 'home#index'

  devise_for :users

  mount Hydramata::Core::Engine, at: 'core'

  mount Hydramata::Deposit::Engine, at: 'deposit'

end
