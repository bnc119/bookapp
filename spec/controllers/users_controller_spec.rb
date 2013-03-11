require 'spec_helper'

describe UsersController do
	render_views
	
  describe "GET 'new'" do
    it "should be successful" do
      get :new
      response.should be_success
    end
    
    it "should have the right title" do
    	get :new
    	response.should have_selector("title", :content => "Sign Up")
    end
  end
  
  describe "GET 'show'" do
  	before :each do
  		@user = Factory(:user)
  	end
  
  	it "should redirect to signin path" do
  		get :show, :id => @user
  		response.should redirect_to signin_path
  	end
  	
  end
  
  describe "POST 'create'" do
  
  	describe "failure" do
			before :each do
				@attr = { :name => "Test User", :email => "test@test.com", 
									:password => "", :password_confirmation => ""}
									
			end
			
			it "should not create the user" do
				lambda do
					post :create, :user=>@attr
					
				end.should_not change(User, :count)
			end
			
			
			it "should have the right title" do
				post :create, :user=>@attr
				response.should have_selector("title", :content => "Sign Up")
			end
  	
  		it "should render the right page " do
				post :create, :user=>@attr
				response.should render_template('new')
			end
			
			
  	end
  	
  	describe "success" do
  	
  		before :each do
				@attr = { :name => "Test User", :email => "test@test.com", 
									:password => "foobar", :password_confirmation => "foobar"}
									
			end
			
			it "should create the user" do
				lambda do
					post :create, :user=>@attr
					
				end.should change(User, :count).by(1)
			end
						
  		it "should render the right page " do
				post :create, :user=>@attr
				response.should redirect_to(user_path(assigns(:user)))
			end
			
			it "should sign the user in " do
				post :create, :user=>@attr
				controller.should be_signed_in
			end
  	
  	end
  
  end
  
  describe 'GET edit' do
    
    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end
    
    it "should include a navbar item for editing profile information" do
      get :edit, :id => @user
      response.should have_selector("a", :href=>edit_user_path, :content => "Account Settings" )
          
    end
    
    it "should be successful" do
      get :edit, :id => @user
      response.should be_success
    end
    
    it "should have the right title" do
      get :edit, :id => @user
      response.should have_selector("title", :content=>"Edit Profile")
      
    end
      
    
  end
  
  describe 'PUT update' do
    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
      
    end
      
    describe 'failure' do
      
      before(:each) do
        @attr = { :email => "", :password => "", :password_confirmation => ""}
      end
    
      it 'should render the edit page' do
        put :update, :id =>@user, :user=>@attr
        response.should render_template('edit')
      end
    
      it 'should have the right title' do
        put :update, :id=> @user, :user=>@attr
        response.should have_selector("title",  :content => "Edit Profile")
      end
      
    end
    
    describe 'success' do
      before(:each) do
        @attr = { :name => "Example User 2", :email => "user@example.com", 
                  :password => "foobaz", :password_confirmation => "foobaz"}
      end
    
      it 'should change the user attributes' do
        put :update, :id => @user, :user => @attr
        @user.reload
        @user.name.should == @attr[:name]
        @user.email.should == @attr[:email]
        
      end
      
      it 'should redirect to the the user show page'  do
        put :update, :id => @user, :user => @attr
        response.should redirect_to(user_path(@user))
      end
      
      it 'should have a flash message indicating succcess update'  do
        put :update, :id => @user, :user => @attr
        flash[:success].should =~ /profile updated/i
      end
      
    end
    
  end
  
  describe 'authentication for show/edit/update' do
  
    before(:each) do
      @user = Factory(:user)
    end
    
    describe 'for non-signed in users' do
      it "should deny access to 'edit' " do
        get :edit, :id => @user
        response.should redirect_to signin_path
      end
      
      it "should deny access to 'update' " do
        put :update, :id => @user, :user => {}
        response.should redirect_to signin_path
        
      end
      
      it 'should deny access to index' do
        get :index
        response.should redirect_to root_path
      end
      
      it 'should deny access to show' do
        get :show, :id=>@user
        response.should redirect_to signin_path
      end
        
    end
    
    describe 'for signedin users' do
      
      before(:each) do
        wrong_user= Factory(:user,:email => Factory.next(:email))
        test_sign_in(wrong_user)  
      end 
      
      it 'should require matching users for edit' do
        get :edit, :id => @user
        response.should redirect_to root_path
        
      end
      
      it 'should require matching users for update' do
        get :edit, :id => @user
        response.should redirect_to root_path
        
      end
      
      it 'should direct to root page' do
        get :show, :id => @user
        response.should redirect_to root_path
      end
      
      it 'should deny access to index' do
        get :index
        response.should redirect_to root_path
      end
      
      
    end  
  end
  
  

end
