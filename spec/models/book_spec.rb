require 'spec_helper'

describe Book do
  
  before :each do
  	
  	@user = Factory(:user)
		
    @attr = { :title => "The Adventures of Tom Sawyer", 
	    :author_last => "Twain", 
	    :author_first => "Mark",
	    :description => "An American classic",
	    :year_published => "1876",
	    :genre => "American Classic", 
	    :isbn => "9780195810400"
	  }
  end
  
  it 'should create a valid instance given complete information' do
    @user.books.create!(@attr)
 
  end
  
  it 'should reject books with duplicate ISBN numbers' do
   @user.books.create!(@attr)
   duplicate_book = Book.new(@attr)
   duplicate_book.should_not be_valid
    
  end
  
  describe 'associations with users' do
    
    before :each do
      @book = @user.books.create!(@attr)
    end
    
    it 'should respond to owners' do
      @book.should respond_to(:owners)
    end
    
    it 'should respond to records' do
      @book.should respond_to(:records)
    end
    
    it 'should have 1 owner' do
       @book.owners.count.should == 1 
    end
     
    
    it 'should belong to the right owner' do
      @book.owners.should include @user
      
    end
    
    it 'should not delete the user if the book gets deleted ' do
      @book.destroy
      @user.should_not be_nil
    end
    
  end
  
end
