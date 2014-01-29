Hydramaton::Application.routes.draw do
  devise_for :users

  mount Hydramata::Core::Engine, at: 'core'

  mount Hydramata::Deposit::Engine, at: 'deposit'

end
