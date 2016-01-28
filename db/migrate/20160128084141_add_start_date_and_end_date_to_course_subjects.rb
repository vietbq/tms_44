class AddStartDateAndEndDateToCourseSubjects < ActiveRecord::Migration
  def change
    add_column :course_subjects, :start_date, :datetime
    add_column :course_subjects, :end_date, :datetime
  end
end
