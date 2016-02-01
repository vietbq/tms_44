module CoursesHelper
  def get_user_subject course_subject
    @user_subject = current_user.user_subjects.find_by course_subject: course_subject
  end
end
