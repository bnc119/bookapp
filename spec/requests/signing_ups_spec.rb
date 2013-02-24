require 'spec_helper'

describe "Users" do
	describe "Sign ups" do
		
		it "should make a new user" do
			lambda do
				visit signup_path
				fill_in "user[name]", :with => "Example User"
				fill_in "user[email]", :with => "example@example.com"
				fill_in "user[password]", :with => "foobar"
				fill_in "user[password_confirmation]", :with => "foobar"
				click_button
				response.should render_template('users/show')
						
			end.should change(User, :count).by(1) 
		end
		
		describe "success" do
		  it "should sign a user in and out" do
		    
		    user = Factory(:user)
		    visit signin_path
		    fill_in "session[email]", :with => user.email
		    fill_in "session[password]", :with => user.password
		    click_button
		    controller.should be_signed_in
		    click_link "Log out"
		    controller.should_not be_signed_in
		    
		  end
		    
		end
		
	
	end
end

