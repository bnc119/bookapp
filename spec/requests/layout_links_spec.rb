require 'spec_helper'

describe "LayoutLinks" do
  
  it "should have a homepage at '/' " do
  	get '/'
  	response.should have_selector('title', :content => "Home")
  end
  
  it "should have a contact page at '/contact' " do
  	get '/contact'
  	response.should have_selector('title', :content => "Contact")
  end
  
  it "should have a sign up page at '/signup' " do
  	get '/signup'
  	response.should have_selector('title', :content => "Sign Up")
  end
  
  it "should have the right links on the layout" do
  	visit root_path
  	click_link "Contact"
  	response.should have_selector("title", :content => "Contact")
  	click_link "Home"
		response.should have_selector("title", :content => "Home")
 
  end
  
  describe "when not signed in " do
  	it "should present the sign in page" do
  		visit root_path
  		response.should have_selector("title", :content=> "Home" )
  	end
  	
  	it "should present the sign up option in the nav bar" do
  		visit root_path
  		response.should have_selector("a", :href=> signup_path, :content => "Sign up!" )
  	end
  
  end
  
  describe "when signed in " do
  	before (:each) do
  		@user = Factory(:user)
  		visit root_path
  		fill_in "session[email]", :with => @user.email
  		fill_in "session[password]", :with => @user.password
			click_button  		
  	end
  	
  	it "should have a sign out link" do 
  		visit root_path
  		response.should have_selector("a", :href=>signout_path, :content => "Log out")
  	
  	end
  end
  
end
