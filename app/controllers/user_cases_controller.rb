class UserCasesController < ActionController::Base
  def reminder
    @sometext = 'Check out!'
    respond_to do |format|
      format.xml
    end
  end
end


