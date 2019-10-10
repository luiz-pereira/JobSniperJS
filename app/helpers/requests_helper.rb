module RequestsHelper

	def parameters_exclude(request)
		request.parameters.select{|a|a.exclude}
	end

	def parameters_include(request)
		request.parameters.reject{|a|a.exclude}
	end

end
