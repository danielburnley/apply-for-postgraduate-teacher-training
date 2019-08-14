Rails.application.routes.draw do
  devise_for :candidates
  root to: 'start_page#show'

  resources :personal_details, only: %i[new create edit update], path: 'personal-details'
  resources :contact_details, only: %i[new create edit update], path: 'contact-details'
  resources :degrees, only: %i[new create edit update]
  resources :qualifications, only: %i[new create edit update]

  get 'check-your-answers', to: 'check_your_answers#show'
  get 'application', to: 'tt_applications#show', as: :tt_application
end
