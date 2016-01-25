class AddStatusToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :status, :integer
  end
end
