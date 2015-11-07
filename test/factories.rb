# factories.rb test data for FactoryGirl

FactoryGirl.define do  factory :enrollment do
    
  end
  

	factory :user do
		sequence :email do |n|
			"usertest#{n}@testloopbackdomain.com"
		end
		password "testmetestme"
		password_confirmation "testmetestme"
	end

	factory :course do
		title "Brew Review"
		description "Survey of brew techniques"
		cost 0
		association :user
	end

	factory :section do
		title "Ancient Brews"
		association :course
	end

	factory :lesson do
		title "Boilers and Percolators"
		association :section
	end

	# factory :complete_course do
	# 	testuser = build(:user)
	# 	course = build(:course, :user_id => testuser.id)
	# 	section = build(:section, :course_id => course.id)
	# 	lesson = create(:lesson, :section_id => section.id)
	# end	
	
end