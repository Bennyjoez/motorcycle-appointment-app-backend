class Users::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token, only: :create

  def create
    user = User.find_by(username: params[:username])
    if user
      sign_in(:user, user)
      render json: user
    else
      render json: { error: 'Invalid username' }, status: :unauthorized
    end
  end
end
