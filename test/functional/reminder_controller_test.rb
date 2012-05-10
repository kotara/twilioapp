require 'test_helper'

class ReminderControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
