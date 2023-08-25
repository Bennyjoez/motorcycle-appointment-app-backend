class Api::ReservationsController < ApplicationController
  before_action :set_reservation, only: [:destroy]
  before_action :set_user, only: [:index, :create]

  def index
    @reservations = @user.reservations
    render json: @reservations
  end

  def create
    @reservation = @user.reservations.build(reservation_params)

    if @reservation.save
      render json: @reservation, status: :created
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  # Other actions and private methods
  def destroy
    if @reservation.destroy
      render json: { message: 'Reservation deleted successfully!'}
    else
      render json: { error: 'Failed to delete the reservation' }, status: :unprocessable_entity
    end
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def set_user
    @user = User.find_by(id: params[:user_id])
    unless @user
      render json: { error: 'User not found' }, status: :not_found
    end
  end

  def reservation_params
    params.require(:reservation).permit(:user_id, :motorcycle_id, :date, :city, :status)
  end
end