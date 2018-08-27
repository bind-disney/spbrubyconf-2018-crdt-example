resources :images,  only: [:index, :show] do
	resources :comments, only: [:create]
	resource :likes, only: :update
  resource :tags, only: :create
end

resources :tags, only: [:index]
