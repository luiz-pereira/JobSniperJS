Rails.application.routes.draw do
	resources :users do
		resources :requests do
			resources :jobs, only: [:index]
		end
	end

	resources :requests
	post 'requests/job_title/new' => 'requests#add_job_title'

  resources :jobs

	root 'static#home'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
	get 'logout' => 'sessions#destroy'

	post '/users/job_titles_selections' => 'users#delete_job_title_selection'

end
