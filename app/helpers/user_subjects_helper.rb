module UserSubjectsHelper
  def user_task_status course_subject_task_id
    user_task = UserTask.find_by user_id: current_user,
      course_subject_task_id: course_subject_task_id
    status = Settings.status[user_task.status]
    @task_class = status.status_class
    @check_box_status = status.check_box
    @check_box_text = status.title
  end
end
