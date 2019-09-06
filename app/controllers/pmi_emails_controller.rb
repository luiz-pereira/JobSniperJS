class PmiEmailsController < ApplicationController


	def index
		redirect_to new_pmi_email_path
	end

	def new
		@pmi_email = PmiEmail.new
	end

	def create
		@pmi_email = PmiEmail.create(pmi_email_params)
		redirect_to pmi_email_path(@pmi_email)
	end

	def show
		@pmi_email=PmiEmail.find(params[:id])
	end

private

	def pmi_email_params
		params.require(:pmi_email).permit(:name, :credentials, :position, :mobile, :email)
	end


end
