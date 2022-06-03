Rails.application.routes.draw do
  root 'pages#index'
  scope module: 'api', path: 'api' do
    scope module: 'v1', path: 'v1' do
      get '/reports/:name' => 'reports#index'
      # resources :reports, only: [:index]
    end
  end
  # namespace :api do
  #   namespace :v1 do
  #     resources :reports, only: [:index], param: :name
  #   end
  # end

  get '*path', to: 'pages#index', via: :all
end
