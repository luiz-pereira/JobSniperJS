Rails.application.routes.draw do
	resources :pmi_emails

	resources :users do
		resources :requests do
			resources :jobs, only: [:index]
			patch '/jobs' => 'jobs#update'
		end
	end

	resources :requests do
		resources :jobs, only: [:index]
	end
	
	post 'requests/job_title/new' => 'requests#add_job_title'
	post 'requests/temp' => "requests#temp"

  resources :jobs

	root 'static#home'


  get '/login' => "session#new"
	post '/login' => "session#create"
	get '/logout' => "session#destroy"
	get '/auth/linkedin/callback' => "session#create"

	
	# teste para o json
	get '/users/:user_id/data/requests' => "users#user_requests_data"
	get '/users/:user_id/data/requests/:request_id' => "requests#request_data"
	get '/users/:user_id/data/requests/:request_id/jobs' => "jobs#jobs_data"

end
