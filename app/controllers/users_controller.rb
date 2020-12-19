class UsersController < ApplicationController
	before_action :authenticate_user! #アクセス制限
	before_action :ensure_correct_user, only: [:edit, :update] #遷移制限

	def index
		@users = User.all
		@book = Book.new
		@user = current_user
	end

	def show
		@user = User.find(params[:id])
		@book = Book.new
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
        if @user.update(user_params)
           flash[:notice] = "You have updated user successfully."
           redirect_to "/users/#{current_user}"
        else
    		flash[:notice] = " errors prohibited this obj from being saved:"
            render :edit
        end
        end

	def ensure_correct_user
		@user = User.find(params[:id])
		if @user.id != current_user.id
			redirect_to user_path(current_user)
		end
	end

	private
	def user_params
		params.require(:user).permit(:name, :introduction, :profile_image)
	end
end