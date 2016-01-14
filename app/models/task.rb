class Task < ActiveRecord::Base
  belongs_to :subject
  has_many :course_subject_tasks, dependent: :destroy
  
  validates :name, presence: true
  validates :description, presence: true
end
