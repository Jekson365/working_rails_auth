class ApplicationController < ActionController::API
  include JsonWebToken
  include ActionController::Cookies

  def not_found
    render json: { error: 'not_found' }
  end

  def authorize_request
    token = cookies.signed[:jwt]
    @decoded = JsonWebToken.decode(token)
    @current_user = User.find(@decoded[:user_id])

  rescue ActiveRecord::RecordNotFound, JWT::DecodeError
    render json: { error: 'unauthorized' }, status: :unauthorized
  end
  def current_user
    return unless cookies.signed[:jwt]

    token = cookies.signed[:jwt]
    decoded = JsonWebToken.decode(token)
    @current_user ||= User.find_by(id: decoded[:user_id])
  rescue JWT::DecodeError, ActiveRecord::RecordNotFound
    nil
  end

  def logout
    cookies.delete(:jwt, domain: :all, secure: true, expires: Time.now - 2.days,same_site: :none)
    render json: {message:"user logged out"},status: :ok
  end
end
