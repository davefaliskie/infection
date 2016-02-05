class CoachStudentsController < ApplicationController

  # used for the form for adding the coach student relationship
	def new
		if params[:student_id] && params[:user_id]
      @user = User.where(id: params[:user_id]).first
			@student = User.where(id: params[:student_id]).first
			@coach_student = CoachStudent.new(student: @student, user: @user)
		else
			flash[:error] = "Sorry there is and error in the CoachStudentsController-new"
		end

	rescue ActiveRecord::RecordNotFound
		render file: 'public/404', status: :not_found
	end


  # creates the actual relationship. 
  def create
    if params[:coach_student] && params[:coach_student].has_key?(:student_id) && params[:coach_student].has_key?(:user_id)
      @user = User.where(id: params[:user_id]).first
		  @student = User.where(id: params[:student_id]).first
		  @coach_student = CoachStudent.new(coach_params)

    if @coach_student.save
        flash[:notice] = "Student Added!"
      else
        flash[:notice] = "There was a problem adding this student."
      end
      # redirects the coach who added the student
      redirect_to user_path(@coach_student.user_id)
    else
      flash[:notice] = "Student required."
      redirect_to root_path
    end

  end

  private

  def coach_params
    params.require(:coach_student).permit(:user_id, :student_id)
  end


end
