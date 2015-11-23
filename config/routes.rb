Rails.application.routes.draw do
  root    'static#home'
   get    'story'       => 'static#story'
   get    'photos'      => 'static#photos'
   get    'cats'        => 'static#cats'
   get    'event'       => 'static#event'
   get    'registries'  => 'static#registries'
   get    'rsvp'        => 'static#rsvp'
end
