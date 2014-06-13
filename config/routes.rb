Copernico::Application.routes.draw do
  match '/', to: 'metadata_records#index', via: 'get'
  match '/metadata/:uuid', to: 'metadata_records#show', via: 'get', as: :metadata

  match '/about_metadata', to: 'static_pages#about_metadata', via: 'get'
  match '/about_project', to: 'static_pages#about_project', via: 'get'

  root 'metadata_records#index'
end
