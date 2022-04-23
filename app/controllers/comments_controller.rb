#= Polymorphic Association of Comment
# Comment model has polymorphic association, but Comment controller refers only the Post model
# please refactor this controller if the polymorphic association really need.
class CommentsController < ApplicationController
  before_action :authorize!, only: [:create, :update, :destroy]
  before_action :set_post
  before_action :set_comment, only: [:show]
  before_action :set_my_comment, only: [:update, :destroy]

  def index
    @comments = @post.comments
  end

  def show
  end

  def create
    @comment = Comment.create!(create_params)
  end

  def update
    @comment.update!(update_params)
  end

  def destroy
    @comment.destroy
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def set_my_comment
    @comment = @post.comments.find(params[:id])
    raise ApiException::Forbidden unless @comment.user_id == @current_user.id
  end

  def create_params
    params[:user_id] = @current_user.id
    params[:record_id] = @post.id
    params[:record_type] = Post.name

    params.permit(:user_id, :record_type, :record_id, :content)
  end

  def update_params
    params.permit(:content)
  end
end
