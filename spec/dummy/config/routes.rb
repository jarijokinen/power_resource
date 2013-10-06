Dummy::Application.routes.draw do
  namespace :backend, path: 'admin'  do
    resources :posts do
      resources :comments
    end
    resources :categories
    root to: 'posts#index'
  end

  resources :categories
  resources :posts do
    resources :comments
  end
  root to: 'posts#index'
end
