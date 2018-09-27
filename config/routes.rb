Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "questions#index"

  resources :questions, only: [:index, :new, :create, :show ] do
    resources :answers, only: [:create] do
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



  resources :users


  namespace :admin do
    root "questions#index"
  end

end
