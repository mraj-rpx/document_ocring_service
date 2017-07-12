Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'documents#index'

  resources :documents, only: [:index, :create, :destroy] do
    collection do
      get :documents
    end
  end

  resources :ocrs, only: [] do
    collection do
      post :patents
    end
  end
end
