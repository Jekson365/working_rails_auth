class PostsController < ApplicationController
  include Pagy::Backend

  def create
    post_params.each do |key, post_data|
      id = post_data['id']
      title = post_data["title"]
      description = post_data["description"]
      image = post_data["image"]
      image_location = post_data['image_location']
      camera = post_data['camera']
      model = post_data['model']

      fn = file_name(image.original_filename)
      Post.create(title:, description:, image: fn, user_id: current_user.id, camera:, image_location:, model:,category_id: Category.first.id)
      save_images(image, fn)
    end
    render json: { message: "success" }, status: :ok
  end

  def index_by_users
    current_user_id = if params[:user_id].present? && params[:user_id] != "undefined"
                        params[:user_id]
                      else
                        current_user.id
                      end
    render json: Post.where(user_id: current_user_id)
  end

  def randomize_posts
    posts = Post.order(created_at: :desc)
                .joins('LEFT JOIN users ON users.id = posts.user_id')
                .joins('LEFT JOIN liked_posts ON liked_posts.post_id = posts.id')
                .select("users.name,posts.id,COUNT(liked_posts.post_id) AS like_count,
                    posts.title,posts.description,posts.image,DATE(posts.created_at),posts.user_id,
                    posts.image_location,posts.camera,posts.model")
                .group('users.name,posts.id,posts.title,posts.description,posts.image')
    @pagy, @items = pagy(posts, page: params[:page], items: params[:items] || 5)
    render json: {
      items: @items,
      pagination: {
        next: @pagy.next,
        last: @pagy.last
      }
    }
  end

  def search_posts
    posts = Post
              .joins("LEFT JOIN users ON users.id = posts.user_id ")
              .select("posts.image,users.id AS user_id,posts.image_location,posts.camera,posts.model")
              .where("posts.camera LIKE ?", "%#{search_post_params[:keyword]}%")

    render json: posts
  end

  private

  def save_images(image, file_name)
    upload_dir = Rails.root.join('public', 'uploads')
    file_path = upload_dir.join(file_name)

    File.open(file_path, 'wb') do |f|
      f.write(image.read)
    end

  end

  def file_name(image_name)
    "#{SecureRandom.uuid}_#{image_name}"
  end

  def post_params
    params.require(:posts).to_unsafe_h
  end

  def user_params
    params.permit(:user_id)
  end

  def search_post_params
    params.permit(:keyword)
  end
end