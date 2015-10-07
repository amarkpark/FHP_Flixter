require 'test_helper'

class CoursesControllerTest < ActionController::TestCase
	test "list all courses" do
		# user = FactoryGirl.create(:user)
		# course = FactoryGirl.create(:course, :user_id => user.id)
		get :index
		assert_response :success
	end
end
