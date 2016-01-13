class Course < ActiveRecord::Base
  has_many :user_courses, dependent: :destroy
  has_many :course_subjects, dependent: :destroy
  has_many :superuser_courses, dependent: :destroy
  
  validates :name, presence: true
  validates :description, presence: true
end
