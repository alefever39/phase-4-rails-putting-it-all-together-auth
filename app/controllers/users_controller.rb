class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  skip_before_action :authorize, only: :create

  def create
    user = User.create!(user_params)
    byebug
    session[:user_id] = user.id
    render json: user, status: :created
  end

  def show
    user = User.find_by(id: session[:user_id])
    render json: user
  end

  private

  def user_params
    params.permit(
      :username,
      :password,
      :password_confirmation,
      :image_url,
      :bio
    )
  end

  def record_not_found
    render json: { error: "Not found" }, status: :not_found
  end
end
