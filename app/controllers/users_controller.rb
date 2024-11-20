class UsersController < ApplicationController
  before_action :authorize_request,only: [:index]
  def index
    render json: 'users'
  end
  def show_current_user
    if current_user
      render json: current_user
    else
      render json: 'unath'
    end
  end
end
