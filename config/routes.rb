Rails.application.routes.draw do

  devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout'}
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
   get    'admin/albums' => 'albums#index'
   resources :albums
   resources :photos, path: '/admin/photos'
   resources :users, path: '/admin/users'
end
