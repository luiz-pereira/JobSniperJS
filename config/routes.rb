Rails.application.routes.draw do
  resources :pmi_emails
	resources :users do
		resources :requests do
			resources :jobs, only: [:index]
		end
	end

	resources :requests
	post 'requests/job_title/new' => 'requests#add_job_title'

  resources :jobs

	root 'static#home'

  get '/login' => "session#new"
	post '/login' => "session#create"
	get '/logout' => "session#destroy"
	get '/auth/linkedin/callback' => "session#create"

	# teste para o json
	get '/requests/:request_id/jobs/json' => "jobs#get_json"

	post '/users/job_titles_selections' => 'users#delete_job_title_selection'

end
