LabInteractiveManagement::Application.routes.draw do

  root 'interactive_searches#new'

  resources :interactives
  resources :interactive_searches

  resources :groups

  resources :models, :path => '/models/:model_type'

end
