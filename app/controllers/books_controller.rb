class BooksController < ApplicationController
  before_action :authenticate_user! #アクセス制限
  before_action :ensure_correct_user, only: [:edit, :update, :destroy] #遷移制限


  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end
  
  def create
      @book = Book.new(book_params)
      @book.user_id = current_user.id
      @user = current_user
      if @book.save
           flash[:notice] = "You have creatad book successfully."
			     redirect_to book_path(@book)
      else
         render 'index'
      end
  end

  def show
      @book = Book.find(params[:id])
      @user = User.find(params[:id])
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
       flash[:notice] = "You have creatad book successfully."
    else
      @books = Book.all
       flash[:notice]= ' errors prohibited this obj from being saved:'
       render :edit
    end
  end

  def destroy
      book = Book.find(params[:id])
      book.destroy
      redirect_to books_path(book.id)
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

