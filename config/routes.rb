Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'documents#index'

  resources :documents, only: [:index, :create, :destroy] do
    collection do
      get :upload_documents
      post :upload_new_documents
    end

    member do
      get :ocr_text
      get :patents
    end
  end

  resources :ocrs, only: [] do
    collection do
      post :patents
    end
  end

  resources :sessions, only: [:new] do
    collection do
      post :login
      post :logout
    end
  end
end
