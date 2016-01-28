module UserCoursesHelper
  def course_status user_course_status
    status = Settings.status[user_course_status]
    @label_class = status.label_class
    @status_text = status.title
  end
end
