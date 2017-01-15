require 'test_helper'

class ProvidesControllerTest < ActionController::TestCase
  test "should get prov" do
    get :prov
    assert_response :success
  end

end
