Rails.application.routes.draw do
  root to: 'proxy#index', as: :index
  get '/output', to: 'proxy#output', as: :output
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
