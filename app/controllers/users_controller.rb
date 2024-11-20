class UsersController < ApplicationController
  before_action :authorize_request
  def index
    render json: 'users'
  end
end
