Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "questions#index"

  resources :questions, only: [:index, :new, :create, :show, :destroy ] do
    resources :answers, only: [:create, :destroy ] do
      member do
        post :answer_upvote
        post :answer_downvote
      end
    end 

    member do
        post :favorite
        post :unfavorite

        post :question_downvote
        post :question_upvote
    end
  end 


  get "/tags", to: "tags#search"
  resources :users, only: [:edit, :show, :index]



  namespace :admin do
    root "questions#index"
    resources :tags
    resources :users
  end

end
