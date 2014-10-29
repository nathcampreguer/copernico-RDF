# -*- encoding : utf-8 -*-
Copernico::Application.routes.draw do
  resources :metadata_records do
    get 'page/:page', :action => :index, :on => :collection
  end
  # match '/', to: 'metadata_records#index', via: 'get'
  match '/metadata/:uuid', to: 'metadata_records#show', via: 'get', as: :metadata

  match '/metadata_rdf/:uuid', to: 'metadata_records_rdf#show', via: 'get', as: :metadata_rdf

  match '/about_metadata', to: 'static_pages#about_metadata', via: 'get'
  match '/about_project', to: 'static_pages#about_project', via: 'get'

  root 'metadata_records#index'
end
