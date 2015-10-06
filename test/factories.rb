# factories.rb test data for FactoryGirl

FactoryGirl.define do
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
end