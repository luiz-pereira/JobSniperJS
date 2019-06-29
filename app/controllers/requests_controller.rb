class RequestsController < ApplicationController
	get '/:username/requests/new' do
		if !logged_in?
			redirect '/login'
		else
			@user = current_user
			erb :request_new_step1
		end
	end

	post '/:username/requests/new' do
			user = current_user
			if !params[:job_titles]
				flash[:error] = "No title was selected. Please click on all the job titles you want to search for"
				redirect to ("/#{user.username}/requests/new")
			else
				request = Request.create #({:date_updated => Time.now})
				user.requests << request
				params[:job_titles].each do |job_title|
					request.job_titles << JobTitle.create(:job_title => job_title.split(' ').map(&:capitalize).join(' '))
				end
				request.locations << Location.create({:city => "Toronto", :province => "Ontario", :country => "Canada"})
				user.save
				request.save
				redirect to ("/#{user.username}/requests/new/#{request.id}/step2")
			end
	end

	post '/:username/add_title' do
		user = current_user
		job_select = params[:title_name].split(' ').map(&:capitalize).join(' ')
		user.job_title_selections << JobTitleSelection.create({:title_select => job_select})
		user.save
		redirect to ("/#{user.username}/requests/new")
	end

	get '/:username/requests/new/:request/step2' do
		@user = current_user
		@reqest = Request.find(params[:request])
		@include = @reqest.parameters.reject(&:exclude)
		@exclude = @reqest.parameters.select(&:exclude)
		erb :request_new_step2
	end

	post '/:username/requests/new/:request/include' do
		user = current_user
		reqest = Request.find(params[:request])
		reqest.parameters << Parameter.create({:criteria => params[:expression], :request_id => params[:request], :exclude => false})
		reqest.save
		redirect to ("/#{user.username}/requests/new/#{reqest.id}/step2")
	end

	delete '/:username/requests/:request/include' do
		user = current_user
		reqest = Request.find(params[:request])
		Parameter.find(params[:include]).destroy
		redirect to ("/#{user.username}/requests/new/#{reqest.id}/step2")
	end

	post '/:username/requests/new/:request/exclude' do
		user = current_user
		reqest = Request.find(params[:request])
		reqest.parameters << Parameter.create({:criteria => params[:expression], :request_id => params[:request], :exclude => true})
		reqest.save
		redirect to ("/#{user.username}/requests/new/#{reqest.id}/step2")
	end

	delete '/:username/requests/:request/exclude' do
		user = current_user
		reqest = Request.find(params[:request])
		Parameter.find(params[:exclude]).destroy
		redirect to ("/#{user.username}/requests/new/#{reqest.id}/step2")
	end

	delete '/:username/requests/:request' do
		Request.find(params[:request]).destroy
		redirect "/#{params[:username]}/home"
	end

	patch '/:username/requests/:request' do
		user = current_user
		reqest = Request.find(params[:request])
		redirect to ("/#{user.username}/requests/new/#{reqest.id}/step2")
	end

	post '/:username/requests/:request' do

		redirect "/#{params[:username]}/requests/#{params[:request]}/update"
	end
end
