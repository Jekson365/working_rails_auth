class LikedPostsController < ApplicationController
  def like_post
    LikedPost.create(user_id: current_user.id, post_id: like_post_params[:post_id])

    render json: {success: "true"}
  end

  private

  def like_post_params
    params.permit(:user_id, :post_id)
  end
end