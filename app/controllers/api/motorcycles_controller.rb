class Api::MotorcyclesController < ApplicationController
  def index
    motorcycles = Motorcycle.all
    render json: motorcycles
  end

  def show
    motorcycle = Motorcycle.find(params[:id])
    render json: motorcycle
  end

  def create
    motorcycle = Motorcycle.new(motorcycle_params)

    if motorcycle.save
      render json: motorcycle, status: :created
    else
      render json: { errors: motorcycle.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    motorcycle = Motorcycle.find(params[:id])
    if motorcycle.destroy
      render json: { message: 'Motorcycle was deleted successfully' }
    else
      render json: { error: 'Failed to delete the motorcycle' }, status: :unprocessable_entity
    end
  end

  private

  def motorcycle_params
    params.require(:motorcycle).permit(:name, :image, :amount, :duration, :description)
  end
end
