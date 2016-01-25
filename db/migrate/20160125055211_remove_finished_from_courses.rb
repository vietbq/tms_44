class RemoveFinishedFromCourses < ActiveRecord::Migration
  def change
    remove_column :courses, :finished, :boolean
  end
end
