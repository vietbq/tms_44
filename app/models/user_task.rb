class UserTask < ActiveRecord::Base
  belongs_to :user
  belongs_to :course_subject_task
  after_save :create_task_activity

  enum status: [:not_start, :trainning, :finish]

  def create_task_activity
    description = self.course_subject_task.task.name + " " + self.status
    Activity.update_activity self.user_id, self.course_subject_task.task.subject,
      Settings.target_type.subject, description
  end

  class << self
    def get_user_tasks user_id, course_subject_task_id
      user_task = UserTask.find_by user_id: user_id,
        course_subject_task_id: course_subject_task_id
    end
  end
end
