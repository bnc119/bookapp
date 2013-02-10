class UsersController < ApplicationController
  def new
  	@user  = User.new
  	@title = "Sign Up"

  end
  
  def show
  	@user = User.find(params[:id])
  	@title = @user.name if @user.valid?
 	end

end
