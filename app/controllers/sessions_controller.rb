class SessionsController < ApplicationController
  def new
  	@title = "Sign in"
  end
  
  def create
	  @title = "Sign in"
  	user = User.authenticate(params[:session][:email],
  													 params[:session][:password])
  	if user.nil?
  		flash.now[:error] = "Invalid email/password combination"
  		render 'new'
  	else
  		sign_in user
  		redirect_back_or user
  		
  	end
  end
  
  def destroy
  	sign_out
  	redirect_to root_path
  end

end
