class UserSubject < ActiveRecord::Base
  belongs_to :user
  belongs_to :course_subject

  enum status: [:not_start, :trainning, :finish]
  
  scope :get_user_subjects, -> user_id{where "user_id = ? and status != 0", user_id}
end
