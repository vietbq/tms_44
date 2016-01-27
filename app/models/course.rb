class Course < ActiveRecord::Base
  has_many :user_courses, dependent: :destroy
  has_many :course_subjects, dependent: :destroy
  accepts_nested_attributes_for :course_subjects, allow_destroy: true
  has_many :superuser_courses, dependent: :destroy
  
  validates :name, presence: true
  validates :description, presence: true

  def get_course_subjects
    list_course_subjects = Array.new
    Subject.all.each do |subject|
      if present_course_subjects.has_key? subject.id
        course_subject = present_course_subjects[subject.id]
      else
        course_subject = CourseSubject.new subject_id: subject.id
      end
      list_course_subjects << course_subject
    end
    list_course_subjects
  end

  def managed_by? superuser
    superuser_courses.find_by superuser_id: superuser.id
  end

  def has_user? user
    user_courses.find_by user_id: user.id
  end

  def get_user_course user
    user_courses.find_by user_id: user.id
  end

  def present_course_subjects
    hash_course_subjects = Hash.new
    course_subjects.each do |course_subject|
      hash_course_subjects[course_subject.subject_id] = course_subject
    end
    hash_course_subjects
  end
end
