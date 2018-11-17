Rails.application.routes.draw do
  resources :weathers, only: %i[index] do
    get 'search', on: :collection
  end
  resources :forecasts, only: %i[index] do
    get 'search', on: :collection
  end
  root to: 'weathers#index'
end
