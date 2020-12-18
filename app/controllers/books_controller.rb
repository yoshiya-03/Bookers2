class BooksController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]


  def index
    @books = Book.all
    @book = Book.new
  end
  
  def create
      @book = Book.new(book_params)
      @book.user_id = current_user.id
      if @book.save
           flash[:notice] = "You have creatad book successfully."
			     redirect_to book_path(@book)
      else
         render 'index'
      end
  end

  def show
      @book = Book.find(params[:id])
      @new_book = Book.new
  end


  def edit
    @book = Book.find(params[:id])
    if @book.user != current_user
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
       redirect_to book_path(@book)
       flash[:notice] = 'Book was successfully updated.'
    else
       render :edit
    end
  end

  def destroy
      book = Book.find(params[:id])
      book.destroy
      redirect_to books_path(book.id)
      flash[:notice] = 'Book was successfully destroyed.'
  end
  
  def ensure_correct_user
		@book = Book.find(params[:id])
		if @book.user_id != current_user.id
			redirect_to books_path
		end
  end


  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

end

