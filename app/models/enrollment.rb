class Enrollment < ActiveRecord::Base
	belongs_to :courses
	belongs_to :users
end
