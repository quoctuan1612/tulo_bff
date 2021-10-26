# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :departments do
    namespace :v1 do
      resources :departments, only: %i[index show create destroy]
    end
  end

  namespace :employees do
    namespace :v1 do
      resources :employees, only: %i[index show create destroy]
    end
  end

  namespace :tasks do
    namespace :v1 do
      resources :tasks, only: %i[index show create destroy]
      resources :reports, only: %i[index show create destroy] do
        collection do
          get :get_reports_by_document_incoming_id
        end
      end
    end
  end

  namespace :documents do
    namespace :v1 do
      resources :document_types, only: %i[index show]
      resources :document_processing_times, only: %i[index show create destroy] do
        collection do
          get :get_processing_time
        end
      end
      resources :document_destinations, only: %i[index show create destroy]
      resources :documents_incoming, only: %i[index show create destroy] do
        collection do
          get :download_file
        end
      end
    end
  end

  namespace :common do
    namespace :v1 do
      resources :roles, only: %i[index show create destroy]
      resources :permissions, only: %i[index show create destroy]
      resources :users, only: %i[index show create destroy] do
        collection do
          get :login
        end
      end
      resources :master, only: %i[] do
        collection do
          get :countries_provinces_districts
          get :wards
        end
      end
    end
  end
end
