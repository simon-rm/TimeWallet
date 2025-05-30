Rails.application.routes.draw do
  root "days#show"

  resources :days, only: %i[index show edit update] do
    collection do
      post :switch_timer
    end
  end

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
