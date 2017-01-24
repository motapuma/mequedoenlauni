require 'test_helper'

class MultipleOptionQuestionsControllerTest < ActionController::TestCase
  test "should get start" do
    get :start
    assert_response :success
  end

end
