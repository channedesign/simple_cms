class AdminUsersController < ApplicationController
	layout "admin"

	before_action :confirm_logged_in

	def index
		@admin_users = AdminUser.sorted
	end

	def new
		@admin_user = AdminUser.new
	end

	def create
		@admin_user = AdminUser.new(admin_user_params)

		if @admin_user.save
			flash[:notice] = "AdminUser has been created successfully"
			redirect_to(:action => "index")
		else
			render "new"
		end
	end

	def edit
		@admin_user = AdminUser.find(params[:id])	
	end

	def update
		@admin_user = AdminUser.find(params[:id])	

		if @admin_user.update_attributes(admin_user_params)
			flash[:notice] = "AdminUser has been updated successfully"
			redirect_to(:action => "index")
		else
			render "edit"
		end
	end

	def delete
		@admin_user = AdminUser.find(params[:id])
	end

	def destroy
		AdminUser.find(params[:id]).destroy
		flash[:notice] = "AdminUser deleted successfully"
		redirect_to(:action => "index")
	end

	private
		def admin_user_params
			params.require(:admin_user).permit(:first_name, :last_name, :username, :email, :password)
		end
		
	

end
