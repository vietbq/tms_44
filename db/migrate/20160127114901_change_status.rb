class ChangeStatus < ActiveRecord::Migration
  def change
    change_column_default :user_courses, :status, 0
    change_column_default :user_subjects, :status, 0
    change_column_default :courses, :status, 0
    change_column_default :course_subjects, :status, 0
  end
end
