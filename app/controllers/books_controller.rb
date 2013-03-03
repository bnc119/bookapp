class BooksController < ApplicationController
    
  def new
    @book = Book.new
    @title = "Add a new book"
    
  end

  def show
    @book = Book.find(params[:id])
  end

  def create
    
    @book = current_user.books.create(params[:book])
    if @book.valid?
      flash[:success] = "You've added a new book to your list!"
			redirect_to @book
    else
      render 'new'
    end
      
  end

  def edit
    @title = "Update your book"
    
  end

  def update
    @book = Book.find(params[:id])
    if @book.update_attributes(params[:book])
      flash[:success] = "Book Updated"
      redirect_to @book
    else
      @title = "Update your book"
      render 'edit'
    end
    
  end

end
