class ApplicationController < ActionController::Base
  protect_from_forgery
before_filter :set_message

def set_message
@sometext = params['sometext']
end
end
