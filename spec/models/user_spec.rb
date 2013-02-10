require 'spec_helper'

describe User do
  
  before :each do
  	@attr = { :name => "foobar", 
  						:email => "email@example.com", 
  						:password => "foobar",
  						:password_confirmation => "foobar"
  					}
  end
  						
  it "should require a name" do
  	no_name_user = User.new(@attr.merge(:name => ""))
  	no_name_user.should_not be_valid
  end
  
  it "should require an email" do
  	no_email_user = User.new(@attr.merge(:email => ""))
  	no_email_user.should_not be_valid
  end
  
  it "should reject names that are too long" do
  	long_name = 'a' * 51
  	long_user = User.new(@attr.merge(:name => long_name))
  	long_user.should_not be_valid
  end
  
  it "should reject email addresses that don't conform to the regex" do
  	bad_email = 'foobar@'
  	e_user = User.new(@attr.merge(:email => bad_email))
  	e_user.should_not be_valid
  end
  
  it "should reject multiple users with the same email address" do
  	User.create!(@attr) 
  	another_user = User.new(@attr)
  	another_user.should_not be_valid
  end
  
  describe "password validations" do
  
  	it "should require a password" do
  		user = User.new(@attr.merge(:password => ""))
  		user.should_not be_valid
  	end
  	
  	it "should require a matching password confirmation" do
  		user = User.new(@attr.merge(:password_confirmation => "invalid"))
  		user.should_not be_valid
  	
  	end
  	
  	it "should reject short passwords" do
  		short_password = 'a' * 5
  		user = User.new(@attr.merge(:password => short_password))
  		user.should_not be_valid
  	
  	end
  	
  	it "should reject long passwords" do
  		long_password = 'a' * 51
  		user = User.new(@attr.merge(:password => long_password))
  		user.should_not be_valid
  	end
  
  end
  
  describe "password encryption" do
  	before :each do
  		@user = User.create!(@attr)
  	end
  	
  	it "should respond to encrypted password" do
			user = User.new(@attr)
			user.should respond_to(:encrypted_password)
  	end
  	
  	it "should set the encrypted password" do
			@user.encrypted_password.should_not be_blank
  	end
  	
  	describe "has_password? method" do
  		it "should be true if the passwords match" do
  			@user.has_password?(@attr[:password]).should be_true
  		
  		end
  		it "should be false if the passwords do not match" do 
  			@user.has_password?("invalid").should be_false
  		
  		end
  	end
  	
  end
  
  describe "authenticate method" do
  
  	it "should return nil on email/password mismatch" do
  		wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
  		wrong_password_user.should be_nil
  	
  	end
  	it "should return for an email address with no user" do
  		wrong_email_user = User.authenticate("wrong@email.com", @attr[:password])
  		wrong_email_user.should be_nil
  	end
  	
  	it "should return the user on email/password match" do
  		matching_user = User.authenticate(@attr[:email], @attr[:password])
  		matching_user.should == @user
  	
  	end
  end

end
