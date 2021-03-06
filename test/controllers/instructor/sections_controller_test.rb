require 'test_helper'

class Instructor::SectionsControllerTest < ActionController::TestCase
	# test "add section requires authenticated user" do
	# 	user = FactoryGirl.create(:user)
	# 	course = FactoryGirl.create(:course, :user_id => user.id)
	# 	get :new, :course_id => course.id
	# 	assert_redirected_to new_user_session_path
	# end

	test "add section requires course owner" do
		user = FactoryGirl.create(:user)
		user2 = FactoryGirl.create(:user)
		sign_in user2
		course = FactoryGirl.create(:course, :user_id => user.id)

		assert_no_difference 'course.sections.count' do
			post :create, :course_id => course.id, :section => { :title => "Week1" }
		end
		assert_redirected_to root_path		
	end	

	test "create section success" do
		user = FactoryGirl.create(:user)
		sign_in user
		course = FactoryGirl.create(:course, :user_id => user.id)
		# need to at some point assert user is a TEACHER
		assert_difference 'course.sections.count' do
			post :create, :course_id => course.id, :section => { :title => "Week1" }
		end
		assert_redirected_to instructor_course_path(course.id)
	end

end
