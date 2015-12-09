Rails.application.routes.draw do

  devise_for :users
  root    'static#home'
   get    'story'       => 'static#story'
   get    'cats'        => 'photos#cats'
   get    'event'       => 'static#event'
   get    'lodging'     => 'static#lodging'
   get    'parking'     => 'static#parking'
   get    'transportation'     => 'static#transportation'
   get    'activities'  => 'static#activities'
   get    'registries'  => 'static#registries'
   get    'rsvp'        => 'static#rsvp'
   get    'photos'      => 'photos#view'
   get    'admin/users' => 'users#index'
   get    'admin/photos' => 'photos#index'
   get    'admin/albums' => 'albums#index'
   resources :photos
   resources :users
   resources :albums
end
