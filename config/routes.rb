Rails.application.routes.draw do
  root    'static#home'
   get    'story'    => 'static#story'
   get    'event'    => 'static#event'
   get    'registries'    => 'static#registries'
end
