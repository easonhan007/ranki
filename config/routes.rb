Rails.application.routes.draw do
  resources :settings

  resources :cards do
    collection do
      get 'ai_gen_back'
    end
  end

  resources :decks
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
end
