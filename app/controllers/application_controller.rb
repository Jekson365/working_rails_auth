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
    return unless cookies.signed[:jwt] # Check if JWT cookie exists

    token = cookies.signed[:jwt]
    decoded = JsonWebToken.decode(token) # Decode the JWT
    @current_user ||= User.find_by(id: decoded[:user_id]) # Memoize and find user
  rescue JWT::DecodeError, ActiveRecord::RecordNotFound
    nil # Return nil if token is invalid or user is not found
  end
end
