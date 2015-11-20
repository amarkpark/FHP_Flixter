require 'test_helper'

class Instructor::LessonsControllerTest < ActionController::TestCase

	test "add lesson requires course owner" do
		user = FactoryGirl.create(:user)
		user2 = FactoryGirl.create(:user)
		sign_in user2
		course = FactoryGirl.create(:course, :user_id => user.id)
		section = FactoryGirl.create(:section, :course_id => course.id)
		assert_no_difference 'section.lessons.count' do
			post :create, :section_id => section.id, :lesson => { :title => "Boilers and Percolators" }
		end
		assert_redirected_to root_path
	end
	
	# test "show new lessons page" do
	# 	user = FactoryGirl.create(:user)
	# 	sign_in user
	# 	course = FactoryGirl.create(:course, :user_id => user.id)
	# 	section = FactoryGirl.create(:section, :course_id => course.id)
	# 	get :new, :section_id => section.id
	# 	assert_response :success
	# end

	test "create lesson success" do
		user = FactoryGirl.create(:user)
		sign_in user
		course = FactoryGirl.create(:course, :user_id => user.id)
		section = FactoryGirl.create(:section, :course_id => course.id)
		# need to at some point assert user is a TEACHER
		assert_difference 'section.lessons.count' do
			post :create, :section_id => section.id, :lesson => { :title => "Boilers and Percolators" }
		end
		assert_redirected_to instructor_course_path(course.id)
	end

	# test "next lesson success" do
	# 	user = FactoryGirl.create(:user)
	# 	sign_in user
	# 	course = FactoryGirl.create(:course, :user_id => user.id)
	# 	section = FactoryGirl.create(:section, :course_id => course.id)
	# 	lesson1 = FactoryGirl.create(:lesson, :section_id => section.id)
	# 	lesson2 = FactoryGirl.create(:lesson, :section_id => section.id)
	# 	get :show, :id => lesson.id
	# 	assert_redirected_to lesson_path(lesson.id)
	# 	post :next_lesson
	# 	assert_redirected_to lesson_path(lesson2.id)
	# end

end
