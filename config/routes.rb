Copernico::Application.routes.draw do
  match '/', to: 'search#index', via: 'get'
  match '/metadata/:uuid', to: 'search#show', via: 'get', as: :metadata

  match '/about_metadata', to: 'static_pages#about_metadata', via: 'get'
  match '/about_project', to: 'static_pages#about_project', via: 'get'

  root 'search#index'
end
