class SessionsController < ApplicationController
  def new
    user = User.find_by(email: user_params[:email].downcase)
    if user && user.authenticate(user_params[:password])
      log_in(user)
      render json: user
    else
      render json: 'incorrect credentials'
    end
  end

  def logout_user
    logout
  end

  private

  def user_params
    params.require(:session).permit(:email, :password)
  end
end
