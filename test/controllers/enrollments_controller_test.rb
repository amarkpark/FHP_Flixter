require 'test_helper'

class EnrollmentsControllerTest < ActionController::TestCase
	test "create enrollment success" do
		user = FactoryGirl.create(:user)
		user2 = FactoryGirl.create(:user)
		sign_in user2
		course = FactoryGirl.create(:course, :user_id => user.id)
		# assert_difference ['user2.enrollments.count', 'course.enrollments.count'], 1 do
		assert_difference 'user2.enrollments.count' do
			post :create, :user_id => user2.id, :course_id => course.id # ActiveRecord::UnknownAttributeError: unknown attribute: course
			# post :create, :user_id => user2.id # ActionController::UrlGenerationError
			# post :create, :course_id => course.id # ActiveRecord::UnknownAttributeError
			# post :create, :course => course # ActionController::UrlGenerationError
		end
		assert_response :success
		enrolled = Enrollment.last
		assert_equal user2, enrolled.user
		assert_equal course, enrolled.course
	end
end
