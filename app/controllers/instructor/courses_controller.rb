class Instructor::CoursesController < ApplicationController
	before_action :authenticate_user!
	before_action :require_auth_for_current_course, :only => [:show] # add edit/delete

	def new
		@course = Course.new
	end

	def create
		@course = current_user.courses.create(course_params)
		if @course.valid?
			@course.enrollments.create(user: current_user)
			redirect_to instructor_course_path(@course)
		else
			render :new, :status => :unprocessable_entity
		end
	end

	def show
		@section = Section.new
		@lesson = Lesson.new
	end

	private

	helper_method :current_course
	def current_course
		@current_course ||= Course.find(params[:id])
	end

	def require_auth_for_current_course
		if current_course.user != current_user
			#eventually change to redirect to dashboard
			redirect_to root_path, flash: {alert: "Unauthorized"} 
			# render :text => "Unauthorized", :status => :unauthorized
			# redirect_to root_path, response_status_and_flash = {:status => :unauthorized}
		end
	end

	def course_params
		params.require(:course).permit(:title, :description, :cost, :image, :remote_image_url)
	end
end
