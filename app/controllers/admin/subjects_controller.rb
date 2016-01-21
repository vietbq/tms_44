class Admin::SubjectsController < ApplicationController
  layout "admin"
  before_action :logged_in_superuser

  def index
    @subjects = Subject.paginate page: params[:page]
  end

  def new
    @subject = Subject.new
    Settings.min_tasks_of_subject.times {@subject.tasks.build}
  end

  def create
    @subject = Subject.new subject_params
    if @subject.save
      flash[:success] = t "admin.subject.created_subject"
      redirect_to admin_root_path
    else
      render :new
    end
  end

  private
  def subject_params
    params.require(:subject).permit :name, :description,
      tasks_attributes: [:id, :name, :description]
  end
end
