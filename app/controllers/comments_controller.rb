class CommentsController < ApplicationController
  def create
	if Comment.create comment_params
		flash[:success] = "successfully comment"
	else
		flash[:danger] = "could not comment"
	end
	redirect_to :back
  end

  def destroy

  end

  private
  def comment_params
  	params.require(:comment).permit(:user_id, :entry_id, :content)
  end
end
