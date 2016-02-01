module UserSubjectsHelper
  def get_subject_status course_subject_id
    user_subject = current_user.user_subjects.
      find_by course_subject_id: course_subject_id
    get_status user_subject.status
  end

  def subject_status user_subject_status
    status = Settings.status[user_subject_status]
    @label_class = status.label_class
    @status_text = status.title
  end

  def user_task_status course_subject_task
    user_task = current_user.user_tasks.
      find_by course_subject_task: course_subject_task
    if course_subject_task.course_subject.finish? && user_task.nil?
      get_status Settings.status.not_finish.status
    elsif
      user_task.present? ? get_status(Settings.status.finish.status) :
        get_status(Settings.status.trainning.status)
    end
  end

  private
  def get_status status
    status = Settings.status[status]
    @task_class = status.status_class
    @check_box_status = status.check_box
    @check_box_text = status.title
  end
end
