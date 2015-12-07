Rails.application.routes.draw do
  root    'static#home'
   get    'story'       => 'static#story'
   get    'photos'      => 'static#photos'
   get    'cats'        => 'static#cats'
   get    'event'       => 'static#event'
   get    'lodging'     => 'static#lodging'
   get    'parking'     => 'static#parking'
   get    'transportation'     => 'static#transportation'
   get    'activities'  => 'static#activities'
   get    'registries'  => 'static#registries'
   get    'rsvp'        => 'static#rsvp'
end
