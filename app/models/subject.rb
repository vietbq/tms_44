class Subject < ActiveRecord::Base
  has_many :course_subjects, dependent: :destroy
  has_many :tasks, dependent: :destroy
  
  validates :name, presence: true
  validates :description, presence: true
end
