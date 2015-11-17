require 'test_helper'

class DashboardsControllerTest < ActionController::TestCase
	test "show dashboard" do
		user = FactoryGirl.create(:user)
		sign_in user
		get :show
		assert_response :success
	end
end
