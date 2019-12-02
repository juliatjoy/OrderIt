class OrdersController < ApplicationController
  before_action :set_user
  before_action :set_order, only: %i[show update destroy]

  def index
    @orders = @user.orders
    render json: {
      status: 200,
      message: 'Success',
      data: @orders
    }
  end


  def create
    @order = @user.orders.create(order_params)
    if @order.persisted?
      render json: {
        status: 200,
        message: 'Success',
        data: @order
      }
    else
      render json: {
        status: 401,
        message: 'Error'
      }
    end
  end

  def update
    if @order.update_attributes(order_params)
      @status = 200
      @message = 'Success'
    else
      @status = 401
      @message = @order.errors.full_messages.to_sentence
    end
    render json: {
        status: @status,
        message: @message,
        data: @order
      }           
  end

  def show
    if @order
      render json: {
        status: 200,
        message: 'Success',
        data: @order
      }
    else
      render json: {
        status: 401,
        message: 'Error'
      }
    end
  end

  def destroy
    if @order.destroy
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

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:menu_id)
  end
end