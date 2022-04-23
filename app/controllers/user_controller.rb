class UserController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
  
  def create
    user = User.create!(user_params)
    session[:user_id] = user.id
    render json: user, status: :created
  end

  def show
    current_user = User.find_by(id: session[:user_id])
    if current_user
      render json: current_user
    else
      render json: { errors: "Not Autherized" }, status: :unauthorized
    end
  end

  private
  def user_params
    params.permit(:username, :password, :password_confirmation)
  end
  
  def render_unprocessable_entity(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end
end
