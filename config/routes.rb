LabInteractiveManagement::Application.routes.draw do

  resources :interactives
  resources :interactive_searches

  resources :groups

  resources :models, :path => '/models/:model_type'

end
