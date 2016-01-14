class CreateUserSubjects < ActiveRecord::Migration
  def change
    create_table :user_subjects do |t|
      t.references :user, index: true, foreign_key: true
      t.references :course_subject, index: true, foreign_key: true
      t.integer :status
      t.datetime :finish_date

      t.timestamps null: false
    end
  end
end
