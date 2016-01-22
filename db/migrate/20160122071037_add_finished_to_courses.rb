class AddFinishedToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :finished, :boolean, default: false
  end
end
