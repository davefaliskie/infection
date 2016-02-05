class CoachStudent < ActiveRecord::Base
	# creates the relationships where User 'coach' & 'student' can be found by 'coach_id' & 'student_id'
	belongs_to :user
	belongs_to :student, class_name: 'User', foreign_key: 'student_id'

end
