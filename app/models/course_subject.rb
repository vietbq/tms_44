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

  def update_status user_id, user_course
    self.update_attributes status: :finish
    description = self.subject.name + " " + self.status
    Activity.update_activity user_id, user_course , Settings.target_type.course, description
  end
end
