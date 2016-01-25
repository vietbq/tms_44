class Course < ActiveRecord::Base
  has_many :user_courses, dependent: :destroy
  has_many :course_subjects, dependent: :destroy
  accepts_nested_attributes_for :course_subjects, allow_destroy: true
  has_many :superuser_courses, dependent: :destroy
  
  validates :name, presence: true
  validates :description, presence: true

  def get_course_subjects
    course_subjects = Array.new
    subjects = Subject.all
    subjects.each do |subject|
      course_subject = CourseSubject.new subject_id: subject.id
      course_subjects << course_subject
    end
    course_subjects
  end
end
