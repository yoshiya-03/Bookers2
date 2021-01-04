class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_current_user, only: [:edit, :update, :destroy]


  def index
  	@book = Book.new
	  @books = Book.all
  end

  def show
  	@book = Book.find(params[:id])
    @books = Book.all
    @user = @book.user
    @newbook = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @books = Book.all
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book)
    else
      render :index
    end
  end


  def edit
  	@book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end


  def ensure_current_user
    book = Book.find(params[:id])
    if book.user != current_user
       redirect_to books_path
    end
  end


  private
    def book_params
      params.require(:book).permit(:title, :body)
    end
end