class Api::ReservationsController < ApplicationController
  before_action :set_reservation,only: [:destroy]
  before_action :set_user

  def index
    @reservations = Reservation.all
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
    @reservation.destroy
    head :no_content
  end
  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def set_user
    @user = User.find_by(id: reservation_params[:user_id])
        unless @user
      render json: { error: 'User not found' }, status: :not_found
    end
  end

  def reservation_params
    params.require(:reservation).permit( :user_id, :motorcycle_id, :date, :city, :status)
  end
end
