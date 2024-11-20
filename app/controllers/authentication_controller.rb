class AuthenticationController < ApplicationController
  before_action :authorize_request, except: :login

  def login
    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 15.seconds.to_i

      cookies.signed[:jwt] = {
        value: token,
        httponly: true,
        expires: time
      }

      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                     username: @user.name }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
