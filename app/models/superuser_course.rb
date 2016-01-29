class SuperuserCourse < ActiveRecord::Base
  belongs_to :superuser
  belongs_to :course

  scope :get_current_courses,
    -> superuser_id {where(superuser_id: superuser_id).order created_at: :asc}
end
