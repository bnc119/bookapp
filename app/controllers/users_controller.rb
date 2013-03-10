
#require 'goodreads'


class UsersController < ApplicationController
  
  before_filter :reject_index, :only => [:index]
  before_filter :authenticate, :only => [:edit, :update]
  before_filter :correct_user, :only => [:edit, :update]
  
  
  def new
  	@user  = User.new
  	@title = "Sign Up"

  end
  
  def show
  	@user = User.find(params[:id])
  	@title = @user.name if @user.valid?
  	@books = @user.books
  	
  	
    #client = Goodreads::Client.new(:api_key =>'48CscoZJ4dWudrtBiOlaqg', 
    #                              :api_secret => '35BVnsO0JCY5XKsF1z8MMt2pM9u61gLPke2z0HB9OFo' )
                                  
    #@search = client.search_books("The Lord of the Rings")
  	
 	end

	def create
		@user = User.new(params[:user])
		if @user.save
			sign_in @user
			flash[:success] = "Welcome to BookSmart!"
			redirect_to @user
		else
			@title = "Sign Up"
			render 'new'
		end
		
	end
	
	def edit
	  @user = User.find(params[:id])
	  @title = "Edit Profile"
	  
	end
	
	
	def update
	 @user = User.find(params[:id])
	 if @user.update_attributes(params[:user])
	  flash[:success] = "Profile Updated"
	  redirect_to @user 
   else
    @title = "Edit Profile"
    render 'edit'
	 end
  end
  
  private
  
  def authenticate
    deny_access unless signed_in?
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless current_user?(@user)
  end
  
  def reject_index 
    redirect_to root_path
  end
  
	
end
