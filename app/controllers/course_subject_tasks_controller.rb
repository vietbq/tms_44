class CourseSubjectTasksController < ApplicationController
  before_filter :logged_in_user

  def create
    @user_subject = UserSubject.find params[:user_subject_id]
    @course_subject_tasks = @user_subject.course_subject.course_subject_tasks
    update_status @course_subject_tasks, params[:status]
    redirect_to @user_subject
  end

  private
  def update_status course_subject_tasks, params
    course_subject_tasks.each do |course_subject_task|
      user_task = UserTask.get_user_tasks current_user.id, course_subject_task.id
      if params && params.include?(course_subject_task.id.to_s) && !user_task
        current_user.user_tasks.create status: :finish, course_subject_task: course_subject_task
      end
    end
  end
end
