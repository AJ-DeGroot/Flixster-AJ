Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :dashboard, only: [:show]
  root 'static_pages#index'
  resources :courses, only: %i[index show] do
    resources :enrollments, only: :create
  end
  resources :lessons, only: %i[show]
  namespace :instructor do
    resources :lessons, only: %i[update]
  	resources :sections, only: %i[update] do
	   	resources :lessons, only: %i[create]
  	end
  	resources :courses, only: %i[new create show] do
  		resources :sections, only: %i[create]
  	end
  end
end
