class User < ActiveRecord::Base
	# relates Users through coach_students table
	has_many :coach_students
	has_many :students, through: :coach_students

	# will allow for a user to get their students.
	def coaches_student?(student)
		students.include?(student)
	end



end
