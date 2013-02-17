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
	
	end
end

