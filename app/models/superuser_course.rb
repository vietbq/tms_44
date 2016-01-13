class SuperuserCourse < ActiveRecord::Base
  belongs_to :superuser
  belongs_to :course
end
