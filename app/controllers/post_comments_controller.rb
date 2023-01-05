class PostCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @new_post_comment = current_user.post_comments.new(post_comment_params)
    @new_post_comment.book_id = @book.id
    @new_post_comment.save
    redirect_to request.referer
  end
  
  def destroy
  end
  
  private
  
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
  
end
