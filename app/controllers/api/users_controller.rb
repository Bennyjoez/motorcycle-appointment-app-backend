class Api::UsersController < ApplicationController
  def register
    user = User.find_or_initialize_by(username: params[:username])

    if user.save
      render json: user, status: :created
    else
      render json: { error: user.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(username: params[:username])

    if user
      render json: user
    else
      render json: { error: 'User not found' }, status: :not_found
    end
  end
end
