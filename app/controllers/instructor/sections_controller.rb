class Instructor::SectionsController < ApplicationController
	before_action :authenticate_user!
	before_action :require_auth_for_current_course

	def new
		@section = Section.new
	end

	def create
		@section = current_course.sections.create(section_params)
		redirect_to instructor_course_path(current_course)
	end

	private

	helper_method :current_course
	def current_course
		@current_course ||= Course.find(params[:course_id])
	end

	def require_auth_for_current_course
		if current_course.user != current_user
			# return render :text => "Unauthorized", :status => :unauthorized
			#eventually change to redirect to dashboard
			redirect_to root_path, flash: {alert: "Unauthorized"} 
		end
	end

	def section_params
		params.require(:section).permit(:title)
	end
end
