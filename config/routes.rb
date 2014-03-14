Hydramaton::Application.routes.draw do
  scope module: :hydramata, as: 'hydramata' do
    resources :groups
  end

  root 'home#index'

  devise_for :users

  mount Hydramata::Core::Engine, at: 'core'

  mount Hydramata::Deposit::Engine, at: 'deposit'

end
