require 'test_helper'

class Instructor::CoursesControllerTest < ActionController::TestCase
	test "add class requires authenticated user" do
		user = FactoryGirl.create(:user)
		get :new
		assert_redirected_to new_user_session_path
	end

	test "show new course page" do
		user = FactoryGirl.create(:user)
		sign_in user
		get :new
		assert_response :success
	end

	test "create class success" do
		user = FactoryGirl.create(:user)
		sign_in user
		# need to at some point assert user is a TEACHER
		assert_difference 'user.courses.count' do
			post :create, :user_id => user.id, :course => {
				:title => "Cupping",
				:description => "Proper tasting methodology",
				:cost => 0
			}
		end
		course = Course.last
		assert_redirected_to instructor_course_path(course.id)
		assert_equal user, course.user
	end

	test "show course detail redirect" do
		user = FactoryGirl.create(:user)
		sign_in user
		course = FactoryGirl.create(:course, :user_id => user.id)
		get :show, :id => course.id
		assert_response :success
	end

	test "course auth fail redirect" do
		user = FactoryGirl.create(:user)
		user2 = FactoryGirl.create(:user)
		sign_in user2
		course = FactoryGirl.create(:course, :user_id => user.id)
		get :show, :id => course.id
		assert_redirected_to root_path
	end

	test "data is valid" do
		user = FactoryGirl.create(:user)
		sign_in user
		assert_no_difference 'user.courses.count' do
			post :create, :user_id => user.id, :course => {
				:description => "this course has no title",
				:cost => 0
			}
		end
		assert_response :unprocessable_entity	
		assert_no_difference 'user.courses.count' do
			post :create, :user_id => user.id, :course => {
				:title => "Course Title with No Desc",
				:cost => 0
			}
		end
		assert_response :unprocessable_entity
		assert_no_difference 'user.courses.count' do
			post :create, :user_id => user.id, :course => {
				:title => "We Pay You",
				:description => "Naughty course with Negitive Cost",
				:cost => -20
			}
		end
		assert_response :unprocessable_entity
	end

	#need course redirect FAIL test
end
