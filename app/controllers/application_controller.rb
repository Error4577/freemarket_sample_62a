class ApplicationController < ActionController::Base
  # include CommonActions
  # before_action :set_categories
  before_action :basic_auth, if: :production?
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:avatar])
  end

  def set_categories
    @categories = Category.where(params[:id])
    @category_children1 = Category.where(parent_id: 1)
    @category_children2 = Category.where(parent_id: 2)
    @category_children3 = Category.where(parent_id: 3)
    @category_children4 = Category.where(parent_id: 4)
    @category_children5 = Category.where(parent_id: 5)
    @category_children6 = Category.where(parent_id: 6)
    @category_children7 = Category.where(parent_id: 7)
    @category_children8 = Category.where(parent_id: 8)
    @category_children9 = Category.where(parent_id: 9)
    @category_children10 = Category.where(parent_id: 10)
    @category_children11 = Category.where(parent_id: 11)
    @category_children12 = Category.where(parent_id: 12)
    @category_children13 = Category.where(parent_id: 13)
  end
  
  private

  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end
end
