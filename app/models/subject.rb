class Subject < ActiveRecord::Base
  has_many :course_subjects, dependent: :destroy
  has_many :tasks, dependent: :destroy
  accepts_nested_attributes_for :tasks, allow_destroy: true
  
  validates :name, presence: true
  validates :description, presence: true
end
