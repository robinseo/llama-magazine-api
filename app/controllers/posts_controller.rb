class PostsController < ApplicationController
  before_action :set_current_user, only: [:index, :show]
  before_action :authorize!, only: [:create, :update, :destroy, :like, :unlike]
  before_action :set_post, only: [:show, :like, :unlike]
  before_action :set_my_post, only: [:update, :destroy]

  def index
    @posts = Post.all
    @posts = @posts.eager_load(:user, :likes) if @current_user
    @posts = @posts.order(order_params)
                   .page(params[:page] || 1)
                   .per(params[:per] || 5)
  end

  def show
  end

  def create
    @post = Post.create!(create_params)

  rescue ArgumentError
    raise ActiveRecord::RecordInvalid
  end

  def update
    @post.update!(update_params)

  rescue ArgumentError
    raise ActiveRecord::RecordInvalid
  end

  def destroy
    @post.destroy
  end

  def like
    raise ApiException::BadRequest, "User already liked this post" if Like.exists?(user_id: @current_user.id, post_id: @post.id)
    Like.create!(user: @current_user, post: @post)
  end

  def unlike
    Like.find_by!(user_id: @current_user.id, post_id: @post.id).destroy
    @post.reload
  end

  private

  def set_post
    @post = Post.find(params[:id] || params[:post_id])
  end

  def set_my_post
    @post = @current_user.posts.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    raise ApiException::Forbidden
  end

  def order_params
    case params[:order]&.to_sym
    when :likes_count_asc
      { likes_count: :asc, id: :desc }
    when :likes_count_desc
      { likes_count: :desc, id: :desc }
    when :id_asc
      { id: :asc }
    else
      { id: :desc }
    end
  end

  def create_params
    params[:user_id] = @current_user.id
    params[:image] = base64_image_to_file(params[:image])
    params.permit(:user_id, :content, :image, :layout)
  end

  def update_params
    params[:user_id] = @current_user.id
    params[:image] = base64_image_to_file(params[:image]) if params[:image].present?
    params.permit(:user_id, :content, :image, :layout)
  end

  def base64_image_to_file(base64_data, filename = nil)
    return base64_data unless base64_data.is_a? String

    start_regex = /data:image\/[a-z]{3,4};base64,/
    filename ||= SecureRandom.hex

    file_ext = Mime::Type.lookup(base64_data.split(';base64').first.gsub('data:', '')).symbol.to_s
    regex_result = start_regex.match(base64_data)

    if base64_data && regex_result
      start = regex_result.to_s
      tempfile = Tempfile.new(filename)
      tempfile.binmode
      tempfile.write(Base64.decode64(base64_data[start.length..-1]))
      name = "#{filename}.#{file_ext}"

      ActionDispatch::Http::UploadedFile.new(tempfile: tempfile, filename: name, original_filename: name)
    else
      nil
    end
  end
end
