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
end
