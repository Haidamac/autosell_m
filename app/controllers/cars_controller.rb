class CarsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[ index show ]
  before_action :set_car, only: %i[ show edit update destroy ]
  before_action :authorize_car, only: %i[ edit update destroy ]

  # GET /cars or /cars.json
  def index
    @cars = if params[:user_id].present?
              Car.filter_by_participant(params[:user_id])
            else
              Car.where(status: 'approved')
            end
  end

  # GET /cars/1 or /cars/1.json
  def show
  end

  def new
    @car = Car.new
  end

  # POST /cars or /cars.json
  def create
    @car = current_user.cars.build(car_params)

    respond_to do |format|
      if @car.save
        format.html { redirect_to car_url(@car), notice: "Car was successfully created." }
        format.json { render :show, status: :created, location: @car }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  # PATCH/PUT /cars/1 or /cars/1.json
  def update
    respond_to do |format|
      if @car.update(car_params)
        format.html { redirect_to car_url(@car), notice: "Car was successfully updated." }
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cars/1 or /cars/1.json
  def destroy
      @car.destroy!
      respond_to do |format|
        format.html { redirect_to cars_url, notice: "Car was successfully destroyed." }
        format.json { head :no_content }
      end
  end

  private

    def authorize_car
      unless @car.user_id == current_user.id
        redirect_to @car, alert: "You are not authorized to perform this action."
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.find(params[:id])
    end

    def car_params
      params.require(:car).permit(:brand, :car_model, :body, :mileage, :color, :price, :fuel, :year, :volume,
      :user_id, :status, images: [])
    end
end
