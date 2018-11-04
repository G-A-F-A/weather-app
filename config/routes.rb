Rails.application.routes.draw do
  resources :weathers, only: %i[index show] do
    get 'search', on: :collection
  end
  root to: 'weathers#index'
end
