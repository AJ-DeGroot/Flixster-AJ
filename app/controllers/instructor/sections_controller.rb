class Instructor::SectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_course, only: [:create]

  def create
    @section = current_course.sections.create(section_params)
    redirect_to instructor_course_path(current_course)
  end

  def update
    current_section.update_attributes(section_params)
  end

  private

  def require_authorized_for_current_course
    render plain: "Unauthorized", status: :unauthorized if current_course.user != current_user
  end

  helper_method :current_course

  def current_course
    if params[:course_id]
      @current_course ||= Course.find(params[:course_id])
    else
      current_section.course
    end
  end

  def section_params
    params.require(:section).permit(:title, :row_order_position)
  end

  def current_section
    @section ||= Section.find(params[:id])
  end
end
