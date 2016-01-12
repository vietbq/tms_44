class CreateSuperuserCourses < ActiveRecord::Migration
  def change
    create_table :superuser_courses do |t|
      t.references :superuser, index: true, foreign_key: true
      t.references :course, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
