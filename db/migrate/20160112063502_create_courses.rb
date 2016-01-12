class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.text :description
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps null: false
    end
  end
end
