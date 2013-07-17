LabInteractiveManagement::Application.routes.draw do

  resources :interactives
  resources :groups

  resources :models, :path => '/models/:model_type'

end
