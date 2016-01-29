module UserCoursesHelper
  def course_status user_course_status
    status = Settings.status[user_course_status]
    @label_class = status.label_class
    @status_text = status.title
  end

  def finish_subject course_subject
    if course_subject.trainning?
      update_course_subject course_subject
    end
    user_subject = current_user.user_subjects.
      find_by course_subject_id: course_subject.id
    user_subject.update_attributes status: :finish
    tasks = course_subject.course_subject_tasks
    tasks.each do |task|
      finish_task task
    end
  end

  def finish_task course_subject_task
    user_task = current_user.user_tasks.
      find_by course_subject_task_id: course_subject_task
    if user_task.present?
      UserTask.create user_id: current_user.id,
        course_subject_task_id: course_subject_task.id, status: :finish
    end
  end

  def update_course_subject course_subject
    course_subject.update_attributes status: :finish
    description = course_subject.course.name + " " + course_subject.status
    Activity.update_activity user_id, course_subject.course,
      Settings.target_type.course, description
  end
end
