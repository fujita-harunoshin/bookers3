class BooksController < ApplicationController
  def index
    @user = User.find(current_user.id)
    @new_book = Book.new
    @books = Book.all
  end

  def create
    @new_book = Book.new(book_params)
    @new_book.user_id = current_user.id
    if @new_book.save
      redirect_to book_path(@new_book.id)
    else
      render :index
    end
  end

  def show
    @new_book = Book.new
    @book = Book.find(params[:id])
    @user = User.find(@book.user.id)
  end

  def edit
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
