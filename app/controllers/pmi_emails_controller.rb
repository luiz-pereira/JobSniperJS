class PmiEmailsController < ApplicationController


	def index
		redirect_to '/pmi-email/new'
	end

	def new
		@pmi_email = PmiEmail.new
	end

	def create
		@pmi_email = PmiEmail.new(pmi_email_params)
		session[:user_pmi] = @pmi_email
		redirect_to "/pmi-email/show"
	end

	def show
		@pmi_email = PmiEmail.new(session[:user_pmi])
	end

private

	def pmi_email_params
		params.require(:pmi_email).permit(:name, :credentials, :position, :phone, :email)
	end


end
