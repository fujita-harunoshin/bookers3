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
      flash[:create_book] = "You have created book successfully."
      redirect_to book_path(@new_book.id)
    else
      # renderの場合、indexアクションを通らず@userが空になる。したがって改めて定義する。
      # @new_book, @booksも同様
      @user = User.find(current_user.id)
      @books = Book.all
      render :index
    end
  end

  def show
    @new_book = Book.new
    @book = Book.find(params[:id])
    @user = User.find(@book.user.id)
    @new_book_comment = BookComment.new
    @book_comments = BookComment.where(book_id: params[:id])
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user != current_user
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    if @book.update(book_params)
      flash[:update_book] = "You have updated book successfully."
      redirect_to book_path(params[:id])
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end


  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
