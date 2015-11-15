class Instructor::SectionsController < ApplicationController
	before_action :authenticate_user!
	before_action :require_auth_for_current_course, :only => [:new, :create]
	before_action :require_auth_for_current_section, :only => [:update]

	def new
		@section = Section.new
	end

	def create
		@section = current_course.sections.create(section_params)
		redirect_to instructor_course_path(current_course)
	end

	def update
		current_section.update_attributes(section_params)
		render :text => 'updated!'
	end

	private

	def current_section
		@current_section ||= Section.find(params[:id])
	end

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

	def require_auth_for_current_section
		if current_course.user != current_user
			render :text => 'Unauthorized', :status => :unauthorized
		end
	end

	def section_params
		params.require(:section).permit(:title, :row_order_position)
	end
end
