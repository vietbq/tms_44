class CourseSubject < ActiveRecord::Base
  belongs_to :course
  belongs_to :subject
  has_many :course_subject_tasks, dependent: :destroy
  has_many :user_subjects, dependent: :destroy

  enum status: [:not_start, :trainning, :finish]
end
