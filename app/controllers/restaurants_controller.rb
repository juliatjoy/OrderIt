class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: %i[show update destroy]

  def index
    @restaurants = Restaurant.all
    render json: {
      status: 200,
      message: 'Success',
      data: @restaurants
    }
  end

  def create
    @restaurant = Restaurant.create(restaurant_params)
    if @restaurant.persisted?
      render json: {
        status: 200,
        message: 'Success',
        data: @restaurant
      }
    else
      render json: {
        status: 401,
        message: 'Error'
      }
    end
  end

  def update
    if @restaurant.update_attributes(restaurant_params)
      @status = 200
      @message = 'Success'
    else
      @status = 401
      @message = 'Error'
    end
    render json: {
        status: @status,
        message: @message,
        data: @restaurant
      }           
  end

  def show
    if @restaurant
      render json: {
        status: 200,
        message: 'Success',
        data: @restaurant
      }
    else
      render json: {
        status: 401,
        message: 'Error'
      }
    end
  end

  def destroy
    if @restaurant.destroy
      render json: {
        status: 200,
        message: 'Success'
      }
    else
      render json: {
        status: 401,
        message: 'Error'
      }
    end
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :description)
  end

  def set_restaurant
    @restaurant = Restaurant.find_by(id: params[:id])
  end
end