class MyCarsController < ApplicationController
  before_action :set_car, only: %i[show update destroy ]

  # GET /my_cars or /my_cars.json
  def index
    @cars = Car.where(user_id: current_user.id)
  end

  # GET /my_cars/1 or /my_cars/1.json
  def show
  end

  # PATCH/PUT /my_cars/1 or /my_cars/1.json
  def update
    respond_to do |format|
      if @car.update(car_params)
        format.html { redirect_to my_car_url(@car), notice: "My car was successfully updated." }
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /my_cars/1 or /my_cars/1.json
  def destroy
    @car.destroy!

    respond_to do |format|
      format.html { redirect_to my_cars_url, notice: "My car was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_my_car
      @car = current_user.cars.find_by(id: params[:id])
      if @car.nil?
        redirect_to cars_path, alert: "Car not found or you don't have permission to view it."
      end
    end

    # Only allow a list of trusted parameters through.
    def car_params
      params.permit(:brand, :car_model, :body, :mileage, :color, :price, :fuel, :year, :volume,
      :user_id, images: [])
    end
end
