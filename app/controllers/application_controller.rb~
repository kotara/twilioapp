class ApplicationController < ActionController::Base
  protect_from_forgery
	before_filter :message
	def message
		$sometext = params['sometext']
	end
end
