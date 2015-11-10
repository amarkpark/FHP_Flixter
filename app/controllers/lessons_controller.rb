class LessonsController < ApplicationController
	before_action :authenticate_user!
	before_action :require_enrolled_for_show_lesson, :only => [:show]

	def show
	end

	private

	helper_method :current_lesson
	def current_lesson
		@current_lesson ||= Lesson.find(params[:id])
	end

	def require_enrolled_for_show_lesson
		unless current_user && (current_user.enrolled_in?(current_lesson.course) || current_user == current_lesson.course.user)
			redirect_to course_path(current_lesson.course), flash: {alert: "You must be enrolled to view lessons!"} 
		end
	end

end
