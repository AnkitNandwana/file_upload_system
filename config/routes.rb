Rails.application.routes.draw do
  devise_for :users
  resources :file_records do
    member do
      post :share
    end
  end

  get "/s/:slug", to: "shared_files#show", as: :shared_file

  root to: "file_records#index"
end
