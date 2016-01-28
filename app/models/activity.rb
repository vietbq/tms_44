class Activity < ActiveRecord::Base
  belongs_to :user

  scope :get_activities, -> user_id, target_type, target_id{
    where(user_id: user_id, target_type: target_type, target_id: target_id).
    order created_at: :desc}
  scope :get_user_activities, -> user_id{where(user_id: user_id).order created_at: :desc}

  class << self
    def update_activity user_id, object, target_type, description
      Activity.create user_id: user_id, target_type: target_type,
        target_id: object.id,
        description: description
    end

    def get_course_activities user_course_id
      activities = Activity.where("target_type = ? AND target_id = ?",
        Settings.target_type.course, user_course_id).order(created_at: :desc).
        limit Settings.limit_activity
    end
  end
end
