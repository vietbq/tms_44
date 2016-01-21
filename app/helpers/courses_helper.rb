module CoursesHelper
  def get_user_subjects course_subject
    @user_subject = UserSubject.get_user_subject course_subject.id, current_user.id 
  end
end
