# app/controllers/api/reservations_controller.rb
class Api::ReservationsController < ApplicationController
  before_action :set_reservation, only: [:destroy]

  def index
    @reservations = Reservation.all
    render json: @reservations
  end

  def create
    @reservation = Reservation.new(reservation_params)

    if @reservation.save
      render json: @reservation, status: :created
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @reservation.destroy
    head :no_content
  end

  private

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:vehicle_app, :model_name, :user_id, :date, :city, :status)
  end
end
