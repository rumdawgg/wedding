Rails.application.routes.draw do

  devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout'}
  root    'static#home'
   get    'story'       => 'static#story'
   get    'cats'        => "albums#show", :id => 1
   get    'us'          => "albums#show", :id => 2
   get    'event'       => 'static#event'
   get    'lodging'     => 'static#lodging'
   get    'parking'     => 'static#parking'
   get    'transportation'     => 'static#transportation'
   get    'activities'  => 'static#activities'
   get    'registries'  => 'static#registries'
   #get    'rsvp'        => 'static#rsvp'
   get    'admin/albums' => 'albums#index'
   get    'admin/photos' => 'photos#index'
   get    'admin/users' => 'users#index'
   resources :albums
   resources :photos, path: '/admin/photos'
   resources :users, path: '/admin/users'
   resources :guest, :meal, :invitees
end
