class UserCourse < ActiveRecord::Base
  belongs_to :user
  belongs_to :course

  enum status: [:not_start, :trainning, :finish]

  def update_status user_id
    self.update_attributes status: :finish
    description = self.course.name + " " + self.status
    Activity.update_activity user_id, self.course , Settings.target_type.course, description
  end
end
