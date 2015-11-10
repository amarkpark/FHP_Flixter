require 'test_helper'

class LessonsControllerTest < ActionController::TestCase
	test "load lesson show page" do
		user = FactoryGirl.create(:user)
		course = FactoryGirl.create(:course, :user_id => user.id)
		section = FactoryGirl.create(:section, :course_id => course.id)
		lesson = FactoryGirl.create(:lesson, :section_id => section.id)
		user2 = FactoryGirl.create(:user)
		sign_in user2
		course.enrollments.create(:user => user2)
		get :show, :id => lesson.id
		assert_response :success
	end

	test "validate enrolled redirect" do
		user = FactoryGirl.create(:user)
		course = FactoryGirl.create(:course, :user_id => user.id)
		section = FactoryGirl.create(:section, :course_id => course.id)
		lesson = FactoryGirl.create(:lesson, :section_id => section.id)
		user2 = FactoryGirl.create(:user)
		sign_in user2
		get :show, :id => lesson.id
		assert_redirected_to course_path(course)
	end
end
