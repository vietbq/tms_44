class Admin::SubjectsController < ApplicationController
  layout "admin"
  before_action :logged_in_superuser
  before_action :load_subject, only: [:edit, :update, :destroy]

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

  def edit
  end

  def update
    if @subject.update_attributes subject_params
      flash[:success] = t "admin.subject.updated"
      redirect_to admin_subjects_path
    else
      render :edit
    end
  end

  def destroy
    @subject.destroy
    flash[:success] = t "admin.subject.deleted"
    redirect_to admin_subjects_path
  end

  private
  def subject_params
    params.require(:subject).permit :name, :description,
      tasks_attributes: [:id, :name, :description, :_destroy]
  end

  def load_subject
    @subject = Subject.find params[:id]
  end
end
