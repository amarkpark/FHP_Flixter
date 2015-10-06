require 'test_helper'

class Instructor::CoursesControllerTest < ActionController::TestCase
	test "show new course page" do
		user = FactoryGirl.create(:user)
		sign_in user
		get :new
		assert_response :success
		# assert_redirected_to new_instructor_course_path
		# WHY doesn't the redirect work?
	end

	test "create class" do
		user = FactoryGirl.create(:user)
		sign_in user
		# need to at some point assert user is a TEACHER
		assert_difference 'user.courses.count' do
			post :create, :user_id => user.id, :course => {:title => "Cupping", :description => "Proper tasting methodology"}
		end
		course = Course.last
		assert_redirected_to instructor_course_path(course.id)
		assert_equal user, course.user
	end

	test "course redirect" do
		user = FactoryGirl.create(:user)
		sign_in user
		course = FactoryGirl.create(:course, :user_id => user.id)
		get :show, :id => course.id
		assert_response :success
	end

	#need course redirect FAIL test
end
