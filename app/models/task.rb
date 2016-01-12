class Task < ActiveRecord::Base
  belongs_to :subject
  has_many :course_subject_tasks, dependent: :destroy
end
