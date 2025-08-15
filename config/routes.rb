require "sidekiq/web"
Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: "_interslice_session"
Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"
  devise_for :users
  resources :file_records do
    member do
      post :share
    end
  end

  get "/s/:slug", to: "shared_files#show", as: :shared_file

  root to: "file_records#index"
end
