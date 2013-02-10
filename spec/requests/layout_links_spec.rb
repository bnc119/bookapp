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
  
end
