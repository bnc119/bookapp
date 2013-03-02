require 'spec_helper'

describe BooksController do
  render_views

  describe "GET 'new'" do
    it "should be successful" do
      get :new
      response.should be_success
    end
  end
  
  describe "GET 'show'" do
    
    before(:each) do
      @book = Factory(:book)
    end
      
    
    it "should be successful" do
      get :show, :id => @book
      response.should be_success
    end
    
    it "should find the right book" do
      get :show, :id => @book
      assigns(:book).should == @book 
    end
  end

  describe "POST 'create'" do
    
    before :each do
      @user = test_sign_in(Factory(:user))
    end
    
    describe 'failure' do
      
      before :each do
        @attr = { :title => "The Adventures of Tom Sawyer", 
	          :author_last => "Twain", 
	          :author_first => "Mark",
	          :description => "An American classic",
	          :year_published => "1876",
	          :genre => "American Classic", 
	          :isbn => ""
	      }
      end
      
      it 'should not create the book given bad attributes' do
        lambda do
          post :create, :book=>@attr
        end.should_not change(Book, :count)
      end
      
      it 'should render the new page given bad attributes' do
        post :create, :book=>@attr
        response.should render_template('new')
      end
      
    end
    
    describe 'success' do
      
      before :each do
        @attr = { :title => "The Adventures of Tom Sawyer", 
	          :author_last => "Twain", 
	          :author_first => "Mark",
	          :description => "An American classic",
	          :year_published => "1876",
	          :genre => "American Classic", 
	          :isbn => "123456ABCD"
	      }
      end
      
      it 'should create the book given good attributes' do
        lambda do
          post :create, :book=>@attr
        end.should change(Book, :count).by(1)
          
      end
      
      it 'should add the book to the users personal list' do
        @user.books.count.should == 1
      end
      
      it 'should render the right page after successful book creation' do
        post :create, :book=>@attr
        response.should redirect_to(book_path(assigns(:book)))
        
      end
      
    end
    
    
    
  end

  describe "GET 'edit'" do
    
    before(:each) do
      @book = Factory(:book)
    end
    
    it "should be successful" do
      get :edit, :id=>@book
      response.should be_success
    end
    
    it "should have the right title " do
      get :edit, :id=>@book
      response.should have_selector("title", :content=>"Update your book")
    end
  end
  
  describe "PUT update" do
    
    
    before(:each) do
      @book = Factory(:book)
    end
    
    
    describe 'failure' do
      
      before :each do
        @attr = { :title => "The Adventures of Tom Sawyer", 
            :author_last => "Twain", 
            :author_first => "Mark",
            :description => "An American classic",
            :year_published => "1876",
            :genre => "American Classic", 
            :isbn => ""
        }
      end
      
      it "should render the right template" do
        put :update, :id=>@book, :book=>@attr
        response.should render_template('edit')  
      end
      
      it "should have the right title " do
        put :update, :id=>@book, :book=>@attr
        response.should have_selector("title", :content=>"Update your book")
      end
      
      
    end
    
    describe 'success' do
      
      before :each do
        @attr = { :title => "The Adventures of Tom Sawyer", 
            :author_last => "Twain", 
            :author_first => "Mark",
            :description => "An American classic",
            :year_published => "1976",
            :genre => "International Classic", 
            :isbn => "123456ABCD"
        }
      end
      
      it 'should update the attributes' do
        put :update, :id=>@book, :book=>@attr
        @book.reload
        @book.year_published.should == @attr[:year_published]
        @book.genre.should == @attr[:genre]
        
      end
      
      it 'should redirect to book show page' do
        put :update, :id=>@book, :book=>@attr
        response.should redirect_to(book_path(@book))
      end 
      
      it 'should have a flash message indicating update was successful' do
        put :update, :id=>@book, :book=>@attr
        flash[:success].should =~ /book updated/i
        
      end
      
    end
    
  end

end
