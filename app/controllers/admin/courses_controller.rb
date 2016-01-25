class Admin::CoursesController < ApplicationController
  layout "admin"
  before_action :logged_in_superuser

  def index
    @courses = Course.paginate page: params[:page]
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new course_params
    if @course.save
      flash[:success] = t "admin.course.created"
      redirect_to admin_courses_path
    else
      render :new
    end
  end

  private
  def course_params
    params.require(:course).permit :name, :description, :start_date, :end_date,
      course_subjects_attributes: [:id, :subject_id, :_destroy]
  end
end
