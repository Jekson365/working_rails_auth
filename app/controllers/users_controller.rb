class UsersController < ApplicationController
  before_action :authorize_request, only: [:index]

  def index
    render json: 'users'
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: { user:, status: :ok }
    else
      render json: { messages: user.errors.full_messages},status: 422
    end
  end

  def show_current_user
    if current_user
      render json: current_user
    else
      render json: nil
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :city, :profession, :password, :password_confirmation)
  end
end
