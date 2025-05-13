Rails.application.routes.draw do
  root "days#today"

  resources :days, only: %i[index show new create update] do
    collection do
      post :switch_mode
      post :finish
    end
  end

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
