
class BooksController < ApplicationController

  def top
  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def show
      @book = Book.find(params[:id])
      @user = User.find(params[:id])
  end

  def create
      @book = Book.new(book_params)
      @book.user = current_user
      if @book.save
         redirect_to book_path(@book.id)
      else
         render 'index'
      end
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

  private
  def book_params
    params.require(:book).permit(:user_id, :title, :body)
  end

end

