class CategoriesController < ApplicationController
  def create
    category = Category.new(category_params)
    if category.save
      render json: category
    else
      render json: category.errors.full_messages
    end
  end
  def index
    render json: Category.all
  end

  private
  def category_params
    params.permit(:name)
  end
end