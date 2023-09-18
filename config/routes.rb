Rails.application.routes.draw do
  resources :stories
  resources :ai_prompts
  get 'answers/ai_gen_content', to: 'answers#gen_content'

  resources :questions do
    resources :answers
  end

  resources :categories
  resources :settings

  resources :cards do
    collection do
      get 'ai_gen_back'
    end
    member do
      get 'toggle'
    end
  end

  resources :decks
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
end
