class UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]

  def index
    @users = User.all
    render json: {
      status: 200,
      message: 'Success',
      data: @users
    }
  end

  def create
    @user = User.create(user_params)
    if @user.persisted?
      render json: {
        status: 200,
        message: 'Success',
        data: @user
      }
    else
      render json: {
        status: 401,
        message: 'Error'
      }
    end
  end

  def update
    if @user.update_attributes(user_params)
      @status = 200
      @message = 'Success'
    else
      @status = 401
      @message = 'Error'
    end
    render json: {
        status: @status,
        message: @message,
        data: @user
      }           
  end

  def show
    if @user
      render json: {
        status: 200,
        message: 'Success',
        data: @user
      }
    else
      render json: {
        status: 401,
        message: 'Error'
      }
    end
  end

  def destroy
    if @user.destroy
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

  def user_params
    params.require(:user).permit(:name)
  end

  def set_user
    @user = User.find_by(id: params[:id])
  end
end