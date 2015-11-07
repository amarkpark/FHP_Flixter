require 'test_helper'

class EnrollmentsControllerTest < ActionController::TestCase
	test "create enrollment success" do
		user = FactoryGirl.create(:user)
		user2 = FactoryGirl.create(:user)
		sign_in user2
		course = FactoryGirl.create(:course, :user_id => user.id)
		assert_difference ['user2.enrollments.count', 'course.enrollments.count'], 1 do
			post :create, :user_id => user2.id, :course_id => course.id
		end
		enrolled = Enrollment.last
		assert_equal user2, enrolled.user
		assert_equal course, enrolled.course
		assert_redirected_to course_path(enrolled.course)
	end
end
