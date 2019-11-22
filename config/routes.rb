Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'products#index'


  resource :products, only: :show
  
  resource :mypage, only: :show do
    member do
      get 'profile'
      get 'card'
      get 'identification'
      get 'logout'
    end
  end
end
