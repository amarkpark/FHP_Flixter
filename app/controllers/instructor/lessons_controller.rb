class Instructor::LessonsController < ApplicationController
	before_action :authenticate_user!
	before_action :require_auth_for_current_section

	def new
		@lesson = Lesson.new
	end

	def create
		@lesson = current_section.lessons.create(lesson_params)
		redirect_to instructor_course_path(current_section.course)
	end

	private

	helper_method :current_section
	def current_section
		@current_section ||= Section.find(params[:section_id])
	end

	def require_auth_for_current_section
		if current_section.course.user != current_user
			# return render flash[:alert] = "Unauthorized", :status => :unauthorized
			#eventually change to redirect to dashboard
			redirect_to root_path, flash: {alert: "Unauthorized"} 
		end
	end

	def lesson_params
		params.require(:lesson).permit(:title, :subtitle, :video, :remote_video_url)
	end
end
