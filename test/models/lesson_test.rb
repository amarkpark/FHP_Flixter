require 'test_helper'

class LessonTest < ActiveSupport::TestCase
	test "next lesson success" do
		user = FactoryGirl.create(:user)
		course = FactoryGirl.create(:course, :user_id => user.id)
		section = FactoryGirl.create(:section, :course_id => course.id)
		lesson1 = FactoryGirl.create(:lesson, :section_id => section.id)
		lesson2 = FactoryGirl.create(:lesson, :section_id => section.id)
		assert_equal lesson1.next_lesson, lesson2
	end
end
