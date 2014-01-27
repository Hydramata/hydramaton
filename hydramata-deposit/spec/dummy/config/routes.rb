Rails.application.routes.draw do

  mount Hydramata::Deposit::Engine => "/deposit"
end
