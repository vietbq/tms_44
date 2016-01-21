class UserSubjectsController < ApplicationController
  before_filter :logged_in_user

  def show
    @user_subject = UserSubject.get_user_subject params[:id], current_user.id
    if @user_subject.nil?
      redirect_to root_path
    else
      @course_subject_tasks = @user_subject.course_subject.course_subject_tasks
      @activities = Activity.get_activities current_user.id,
        Settings.target_type.subject, @user_subject.course_subject.subject_id
      @title_for_layout = t("subject.title") +
        @user_subject.course_subject.subject.name
    end
  end
end
