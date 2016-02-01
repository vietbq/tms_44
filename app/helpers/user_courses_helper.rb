module UserCoursesHelper
  def course_status user_course_status
    status = Settings.status[user_course_status]
    @label_class = status.label_class
    @status_text = status.title
  end

  def finish_subject course_subject
    if course_subject.trainning?
      update_course_subject course_subject
      user_subject = current_user.user_subjects.
        find_by course_subject_id: course_subject.id
      user_subject.update_attributes status: :finish
      tasks = course_subject.course_subject_tasks
      tasks.each do |task|
        finish_task task
      end
    else
      flash[:danger] = t "subject.error_not_start"
    end
  end

  def finish_task course_subject_task
    if course_subject_task.course_subject.trainning?
      user_task = current_user.user_tasks.
        find_by course_subject_task_id: course_subject_task
      if user_task.present?
        current_user.user_tasks.create course_subject_task_id: course_subject_task,
          status: :finish
      end
    else
      flash[:danger] = t "subject.error_not_start"
    end
  end

  def update_course_subject course_subject
    course_subject.update_attributes status: :finish
    description = course_subject.course.name + " " + course_subject.status
    Activity.update_activity user_id, course_subject.course,
      Settings.target_type.course, description
  end
end
