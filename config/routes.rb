Rails.application.routes.draw do

  resource :chat do
    get :connect
    resources :messages, only: [:create]
  end

  root to: 'chats#show'

end
