Rails.application.routes.draw do
  root    'static#home'
   get    'story'       => 'static#story'
   get    'cats'        => 'static#cats'
   get    'event'       => 'static#event'
   get    'registries'  => 'static#registries'
   get    'rsvp'        => 'static#rsvp'
      get    'photos'      => 'photos#new'
      resources :photos
end
