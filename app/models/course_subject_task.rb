class CourseSubjectTask < ActiveRecord::Base
  belongs_to :course_subject
  belongs_to :task
end
