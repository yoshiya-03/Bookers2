
class BooksController < ApplicationController
  
  def top
  end 

  def index
      @books = Book.all.order(created_at: :desc)
      @book = Book.new
  end

  def show
      @book = Book.find_by(id:params[:id])
      @user = User.find_by(id: @book.user_id)
  end

  def create
      @book = Book.new(book_params)
        @book.user_id = current_user.id
      if @book.save
         flash[:notice] = 'Book was successfully created.'
         redirect_to book_path(@book.id)
      else
         @books = Book.all
         render 'new'
      end
  end

  def edit
      @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
       redirect_to book_path(@book)
       flash[:notice] = 'Book was successfully updated.'
    else
       render action: :edit
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
    params.require(:book).permit(:title, :body)
  end

end

