class LessonsController < ApplicationController
	before_action :authenticate_user!
	before_action :require_authorized_for_current_lesson, only: [:show]

	def show
	end

	def require_authorized_for_current_lesson
		redirect_to course_path(current_lesson.section.course), alert: 'Enroll in Course to View Lessons' if !current_user.enrolled_in?(current_lesson.section.course) == true
	end

		private

	helper_method :current_lesson
	def current_lesson
		@curent_lesson ||= Lesson.find(params[:id])
	end
end
