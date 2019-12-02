class MenusController < ApplicationController
  before_action :set_restaurant
  before_action :set_menu, only: %i[show update destroy]

  def index
    @mens = @restaurant.menus
    render json: {
      status: 200,
      message: 'Success',
      data: @mens
    }
  end

  def create
    @menu = @restaurant.menus.create(menu_params)
    if @menu.persisted?
      render json: {
        status: 200,
        message: 'Success',
        data: @menu
      }
    else
      render json: {
        status: 401,
        message: @menu.errors.full_messages.to_sentence
      }
    end
  end

  def update
    if @menu.update_attributes(menu_params)
      @status = 200
      @message = 'Success'
    else
      @status = 401
      @message = @menu.errors.full_messages.to_sentence
    end
    render json: {
        status: @status,
        message: @message,
        data: @menu
      }           
  end

  def show
    if @menu
      render json: {
        status: 200,
        message: 'Success',
        data: @menu
      }
    else
      render json: {
        status: 401,
        message: 'Error'
      }
    end
  end

  def destroy
    if @menu.destroy
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

  def menu_params
    params.require(:menu).permit(:name, :description, :menu_type)
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end


  def set_menu
    @menu = Menu.find_by(id: params[:id])
  end
end