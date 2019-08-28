class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    @users = User.where.not(id: current_user.id)
  end

  def new
    @title = 'Creating new user'
    @user = User.new
  end

  def create
    @user = User.create(allowed_params)
    @user.save
  end

  def update
    @user.update_attributes(allowed_params)
  end

  def edit
    @title = "Update user #{@user.email}"
  end

  def destroy
    @user.destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def allowed_params
    params.require(:user).permit!
  end
end
