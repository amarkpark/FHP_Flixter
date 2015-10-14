require 'test_helper'

class CoursesControllerTest < ActionController::TestCase
	test "list all courses" do
		# user = FactoryGirl.create(:user)
		# course = FactoryGirl.create(:course, :user_id => user.id)
		get :index
		assert_response :success
	end

	test "show course detail" do
		user = FactoryGirl.create(:user)
		course = FactoryGirl.create(:course, :user_id => user.id)
		get :show, :id => course.id
		# assert_redirected_to course_path(course)
		assert_response :success
	end
end
