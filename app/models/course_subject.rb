class CourseSubject < ActiveRecord::Base
  belongs_to :course
  belongs_to :subject
  has_many :course_subject_tasks, dependent: :destroy
  has_many :user_subjects, dependent: :destroy

  enum status: [:not_start, :trainning, :finish]

  def finish_task? user, task
    course_subject_task = course_subject_tasks.find_by task_id: task.id
    course_subject_task.user_tasks.find_by user_id: user.id if course_subject_task.present?
  end
end
