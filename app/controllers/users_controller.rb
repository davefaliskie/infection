class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  def index
    @users = User.all
    @user = User.new

  end

  # GET /users/1/edit
  def edit
  end

  def show
    @users = User.all
  end

  # POST /users
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to root_path, notice: 'User was successfully created.' }
      else
        format.html { redirect_to root_path, notice: 'There was a problem creating this user, please try again.' }
      end
    end
  end

  # PATCH/PUT /users/1
  def update
    respond_to do |format|
      if @user.update(user_params)
      
      # !!!!!!! This is the infect method !!!!!!!!
      # If a user is the student of the user who is getting a :site_version change, 
      # the student user will also be changed to that version.

       User.all.each do |student| 
         while @user.coaches_student?(student) 
           student.update(site_version: @user.site_version)
           # changes the user to the student to change the version of their students as well.
           @user = student 
         end
       end 


        format.html { redirect_to root_path, notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:user_name, :site_version)
    end

end
