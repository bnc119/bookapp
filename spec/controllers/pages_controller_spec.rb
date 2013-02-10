require 'spec_helper'

describe PagesController do
	render_views
	
	before :each do
		@basetitle = "BookSmart"
	end 
	
  describe "GET 'home'" do
    it "should be successful" do
      get :home
      response.should be_success
    end
    
    it "should have the right title" do
    	get :home
    	response.should have_selector("title", :content => @basetitle + " | Home")
    end
  end
  
  

  describe "GET 'contact'" do
    it "should be successful" do
      get :contact
      response.should be_success
    end
    
    it "should have the right title" do
    	get :contact
    	response.should have_selector("title", :content => @basetitle + " | Contact")
    end
    
    it "should have a link to the github source" do
    	get :contact
    	response.should have_selector("a", :href => "https://github.com/bnc119/bookapp", :content => "GitHub project page")
    end
  end

end
